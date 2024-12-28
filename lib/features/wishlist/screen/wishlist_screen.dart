import 'package:book_app_basic_arch/core/shared/widgets/styled_app_bar.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_grid.dart';
import 'package:book_app_basic_arch/features/wishlist/enum_wishlist_operation.dart';
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

    return Scaffold(
      appBar: StyledAppBar(
        title: const Text(
          "Wislist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => wishlistProvider.getBooksWishlished(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<WishlistProvider>(
            builder: (context, provider, _) {
              final books = provider.books;
              final isLoading =
                  provider.isLoading(EnumWishlistOperation.getAll);
              final errorMessage =
                  provider.getError(EnumWishlistOperation.getAll);

              return BookGrid(
                books: books,
                isLoading: isLoading,
                onBookSelected: (book) {
                  context.push('/books/${book.id}');
                },
                errorMessage: errorMessage,
                onRetry: () => wishlistProvider.getBooksWishlished(),
              );
            },
          ),
        ),
      ),
    );
  }
}
