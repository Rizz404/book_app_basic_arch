import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_list_horizontal.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatelessWidget {
  final String genreId;

  const GenreDetailScreen({
    super.key,
    required this.genreId,
  });

  Future<void> _initializeData(BuildContext context) async {
    final genreProvider = context.read<GenreProvider>();
    final bookProvider = context.read<BookProvider>();

    await genreProvider.getGenreById(genreId);
    await genreProvider.getGenres(screen: GenreScreenType.genreDetail);

    final currentFilter = bookProvider.getFilterForSpecificScreen(
      BookScreenType.genreDetail,
    );

    if (currentFilter.genreId != genreId) {
      bookProvider.updateFilterForSpecificScreen(
        BookScreenType.genreDetail,
        currentFilter.copyWith(genreId: genreId, page: 1),
      );

      await bookProvider.getBooks(screen: BookScreenType.genreDetail);
    }
  }

  Future<void> _handleRefresh(BuildContext context) async {
    await Future.wait([
      context.read<GenreProvider>().getGenreById(genreId),
      context.read<BookProvider>().getBooks(
            screen: BookScreenType.genreDetail,
          ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData(context);
    });

    return BaseScaffold(
      body: RefreshIndicator(
        onRefresh: () => _handleRefresh(context),
        child: StyledScreenLayoutBuilder(
          sliverAppBar: StyledSliverAppBar(
            title: StyledSearchBarPlaceholder(
              hintText: "Hinted search text",
            ),
          ),
          builder: (builder, controller) {
            return [
              SliverToBoxAdapter(
                child: Consumer<GenreProvider>(
                  builder: (context, genreProvider, _) {
                    final isLoadingGenre = genreProvider
                        .isLoading(GenreOperationType.getGenreById);
                    final errorMessageGenre =
                        genreProvider.getError(GenreOperationType.getGenreById);
                    final genre = genreProvider.genre;

                    final isLoadingGenres =
                        genreProvider.isLoading(GenreOperationType.getGenres);
                    final errorMessageGenres =
                        genreProvider.getError(GenreOperationType.getGenres);
                    final genres = genreProvider.getGenresForSpecificScreen(
                        GenreScreenType.genreDetail);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGenreCard(
                          context,
                          isLoadingGenre,
                          errorMessageGenre,
                          genre,
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Similar Genres",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(height: 16),
                        GenreListHorizontal(
                          isLoading: isLoadingGenres,
                          errorMessage: errorMessageGenres,
                          genres: genres,
                          onRetry: () => genreProvider.getGenres(
                              screen: GenreScreenType.genreDetail),
                          onGenreSelected: (genreId) => context.push(
                            '/genres/$genreId',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 32,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Our Books",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final isLoading =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessage =
                      bookProvider.getError(BookOperationType.getBooks);
                  final books = bookProvider
                      .getBooksForSpecificScreen(BookScreenType.genreDetail);

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoading,
                      errorMessage: errorMessage,
                      onLoadMore: () async => await bookProvider
                          .loadMoreBooks(BookScreenType.genreDetail),
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      scrollController: controller,
                      onRetry: () async => await bookProvider.getBooks(
                        screen: BookScreenType.genreDetail,
                      ),
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ),
    );
  }

  Widget _buildGenreCard(
    BuildContext context,
    bool isLoading,
    String? errorMessage,
    GenreModel? genre,
  ) {
    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledLoadingState(),
        ),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: StyledErrorMessage(
            errorMessage: errorMessage,
            onRetry: () {
              context.read<GenreProvider>().getGenreById(genreId);
            },
          ),
        ),
      );
    }

    if (genre == null) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledEmptyData(message: 'Genre not found'),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  genre.picture,
                  fit: BoxFit.cover,
                  width: 120,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      genre.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 6),
                    Text(
                      genre.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
