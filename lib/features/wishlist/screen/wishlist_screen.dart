import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid.dart';
import 'package:book_app_basic_arch/features/wishlist/enums/wishlist_operation_type.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistProvider.getBooksWishlished();
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
          sliverAppBar: StyledSliverAppBar(
            title: Text('Wishlist'),
            centerTitle: true,
          ),
          builder: (builder, controller) {
            return [
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: Consumer<WishlistProvider>(
                  builder: (context, provider, _) {
                    final books = provider.getBooksForScreen('wishlist');
                    final isLoading = provider
                        .isLoading(WishlistOperationType.getBooksFromWishlish);
                    final errorMessage = provider
                        .getError(WishlistOperationType.getBooksFromWishlish);

                    return SliverToBoxAdapter(
                      child: BookGrid(
                        books: books,
                        isLoading: isLoading,
                        onBookSelected: (book) {
                          context.push('/books/${book.id}');
                        },
                        errorMessage: errorMessage,
                        onRetry: () => wishlistProvider.getBooksWishlished(),
                      ),
                    );
                  },
                ),
              )
            ];
          }),
    );
  }
}
