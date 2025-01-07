import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  Future<void> _fetchData(BuildContext context) async {
    final bookProvider = context.read<BookProvider>();

    await bookProvider.getBooksInWishlist(screen: BookScreenType.wishlist);
  }

  Future<void> _handleRefresh(BuildContext context) async {
    final bookProvider = context.read<BookProvider>();

    bookProvider.updateFilterForSpecificScreen(
      BookScreenType.wishlist,
      bookProvider
          .getFilterForSpecificScreen(BookScreenType.wishlist)
          .copyWith(page: 1),
    );
    await bookProvider.getBooksInWishlist(screen: BookScreenType.wishlist);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData(context);
    });

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(
          title: Text('Wishlist'),
          centerTitle: true,
        ),
        builder: (builder, controller) {
          return [
            Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books = bookProvider
                    .getBooksForSpecificScreen(BookScreenType.wishlist);
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
                      BookScreenType.wishlist,
                    ),
                    onLoadMore: () =>
                        bookProvider.loadMoreBooks(BookScreenType.wishlist),
                    onRetry: () => bookProvider.getBooks(
                      screen: BookScreenType.wishlist,
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
