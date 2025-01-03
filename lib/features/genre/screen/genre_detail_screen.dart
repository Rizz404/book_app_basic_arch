import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // * Kalo stateles itu pakenya read aja
      _initializeData(context);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
          sliverAppBar: StyledSliverAppBar(
            title: Text('Genre'),
          ),
          builder: (context, controller) {
            return [
              StyledStickySliverContainer(
                backgroundColor: Colors.grey.shade500,
                height: 72,
                child: Consumer<GenreProvider>(
                  builder: (builder, provider, _) {
                    final isLoadingGenre =
                        provider.isLoading(GenreOperationType.getGenreById);
                    final errorMessageGenre =
                        provider.getError(GenreOperationType.getGenreById);
                    final genre = provider.genre;

                    if (isLoadingGenre) {
                      return StyledLoadingState();
                    }

                    if (errorMessageGenre != null) {
                      return StyledErrorMessage(
                          errorMessage: errorMessageGenre);
                    }

                    if (genre == null) {
                      return StyledEmptyData(message: 'Genre not found');
                    }

                    return ListTile(
                      title: Text(genre.name),
                      subtitle: Text(
                        genre.description,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: Consumer<BookProvider>(
                  builder: (context, bookProvider, _) {
                    final isLoadingBooks =
                        bookProvider.isLoading(BookOperationType.getBooks);
                    final errorMessageBooks =
                        bookProvider.getError(BookOperationType.getBooks);
                    final books = bookProvider.getBooksForSpecificScreen(
                      BookScreenType.genreDetail,
                    );

                    return InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoadingBooks,
                      errorMessage: errorMessageBooks,
                      onRetry: () async => await bookProvider.getBooks(
                        screen: BookScreenType.genreDetail,
                      ),
                      onLoadMore: () async {
                        await bookProvider.loadMoreBooks(
                          BookScreenType.genreDetail,
                        );
                      },
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      scrollController: controller,
                    );
                  },
                ),
              ),
            ];
          }),
    );
  }
}
