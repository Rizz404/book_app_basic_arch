import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_list_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenreDetailScreen extends StatefulWidget {
  final String genreId;

  const GenreDetailScreen({
    super.key,
    required this.genreId,
  });

  @override
  State<GenreDetailScreen> createState() => _GenreDetailScreenState();
}

class _GenreDetailScreenState extends State<GenreDetailScreen> {
  Future<void> _fetchData() async {
    final genreProvider = context.read<GenreProvider>();
    final bookProvider = context.read<BookProvider>();

    await genreProvider.getGenreById(widget.genreId);
    await genreProvider.getGenres(screen: GenreScreenType.genreDetail);

    final currentFilter = bookProvider.getFilterForSpecificScreen(
      BookScreenType.genreDetail,
    );

    bookProvider.updateFilterForSpecificScreen(
      BookScreenType.genreDetail,
      currentFilter.copyWith(genreId: widget.genreId, page: 1),
    );

    await bookProvider.getBooks(screen: BookScreenType.genreDetail);
  }

  @override
  void didUpdateWidget(covariant GenreDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.genreId != widget.genreId) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _fetchData();
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: RefreshIndicator(
        onRefresh: () => _fetchData(),
        child: StyledScreenLayoutBuilder(
          sliverAppBar: const StyledSliverAppBar(
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
                    final genre =
                        genreProvider.getGenreByIdFromCache(widget.genreId);

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
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Similar Genres",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                padding: const EdgeInsets.only(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
              context.read<GenreProvider>().getGenreById(widget.genreId);
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      genre.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      genre.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
