import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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

    return BaseScaffold(
      body: RefreshIndicator(
        onRefresh: () => _handleRefresh(context),
        child: StyledScreenLayoutBuilder(
            sliverAppBar: StyledSliverAppBar(
              title: Text('Wishlist'),
              centerTitle: true,
            ),
            builder: (builder, controller) {
              return [
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: Consumer<BookProvider>(
                    builder: (context, bookProvider, _) {
                      final books = bookProvider
                          .getBooksForSpecificScreen(BookScreenType.wishlist);
                      final isLoading = bookProvider
                          .isLoading(BookOperationType.getBooksInWishlist);
                      final errorMessage = bookProvider
                          .getError(BookOperationType.getBooksInWishlist);

                      return InfiniteScrollBookGrid(
                        books: books,
                        isLoading: isLoading,
                        errorMessage: errorMessage,
                        onLoadMore: () =>
                            bookProvider.loadMoreBooks(BookScreenType.wishlist),
                        onBookSelected: (book) {
                          context.push('/books/${book.id}');
                        },
                        scrollController: controller,
                        onRetry: () => bookProvider.getBooks(
                          screen: BookScreenType.wishlist,
                        ),
                      );
                    },
                  ),
                )
              ];
            }),
      ),
    );
  }
}
