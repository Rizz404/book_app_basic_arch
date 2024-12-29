import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap; // Tambahan prop untuk wishlist

  const BookCard({
    super.key,
    required this.bookModel,
    this.onTap,
    this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/books/${bookModel.id}'),
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Image with Wishlist Button
            Expanded(
              child: Stack(
                children: [
                  // Image
                  Image.network(
                    bookModel.bookPictures![0].url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://i.pinimg.com/236x/64/2e/96/642e9610c5c587767430bf6a9deeff7c.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                    cacheWidth: 300,
                    cacheHeight: 300,
                  ),

                  // Wishlist Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          bookModel.isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: bookModel.isWishlisted
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          if (bookModel.isWishlisted) {
                            context
                                .read<WishlistProvider>()
                                .deleteWishlist(bookModel.id);
                          } else {
                            context
                                .read<WishlistProvider>()
                                .createWishlist(bookModel.id);
                          }
                        },
                        constraints: BoxConstraints.tight(
                          Size(36, 36),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // * Text
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    bookModel.author.name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
