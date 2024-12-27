import 'package:flutter/material.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;
  final VoidCallback? onTap;

  const BookCard({
    super.key,
    required this.bookModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? coverImage = bookModel.bookPictures?[0].url;
    final bool isPlaceholderImage = coverImage == 'http://placeimg.com/640/480';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(4), // Margin diperkecil
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2, // Elevation dikurangi agar tidak terlalu menonjol
        child: Stack(
          children: [
            // Background Image
            if (coverImage != null && !isPlaceholderImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  coverImage,
                  height: 220, // Tinggi disesuaikan
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholder(),
                ),
              )
            else
              _buildPlaceholder(),
            // Gradient Overlay
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Book Title
                  Text(
                    bookModel.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Book Description
                  Text(
                    bookModel.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Price & Stock Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${bookModel.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Stock: ${bookModel.stock}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              'No Cover',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
