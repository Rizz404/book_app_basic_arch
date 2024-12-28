import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';

// todo: Nanti pindahin di folder widget books
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Image
            Expanded(
              child: Image.network(
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
                cacheWidth:
                    300, // * Mengaktifkan caching dengan resolusi tertentu
                cacheHeight: 300, // * Sesuaikan dengan kebutuhan
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
