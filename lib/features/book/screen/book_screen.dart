import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks(screen: BookScreenType.books);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(
          title: StyledSearchBarPlaceholder(),
        ),
        builder: (builder, controller) {
          return [
            Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books = bookProvider
                    .getBooksForSpecificScreen(BookScreenType.books);
                final isLoadingBooks =
                    bookProvider.isLoading(BookOperationType.getBooks);
                final errorMessageBooks =
                    bookProvider.getError(BookOperationType.getBooks);

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: InfiniteScrollBookGrid(
                    books: books,
                    isLoading: isLoadingBooks,
                    errorMessage: errorMessageBooks,
                    emptyMessage: 'Book is empty, try to add one admin!!',
                    scrollController: controller,
                    onBookSelected: (book) {
                      context.push('/books/${book.id}');
                    },
                    isInitialLoading: bookProvider.isInitialLoad(
                      BookScreenType.books,
                    ),
                    onLoadMore: () =>
                        bookProvider.loadMoreBooks(BookScreenType.books),
                    onRetry: () => bookProvider.getBooks(
                      screen: BookScreenType.books,
                    ),
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }
}
