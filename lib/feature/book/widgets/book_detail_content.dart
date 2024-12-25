import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_form.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_image_carousel.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_info_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookDetailContent extends StatelessWidget {
  final BookModel bookModel;

  const BookDetailContent({super.key, required this.bookModel});

  void _showEditDialog(BuildContext context, BookModel book) {
    showDialog(
      context: context,
      builder: (context) => BookForm(
        updateBookModel: UpdateBookModel(
          id: book.id,
          title: book.title,
          genreIds: book.genres.map((genre) => genre.id).toList(),
          description: book.description,
          isbn: book.isbn,
          stock: book.stock,
          price: book.price,
          fileUrl: book.fileUrl,
          publicationDate: book.publicationDate,
          authorId: book.author.id,
          publisherId: book.publisher.id,
          language: book.language,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar dengan image carousel
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background:
                BookImageCarousel(bookPictures: bookModel.bookPictures!),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditDialog(context, bookModel),
            ),
          ],
        ),
        // Konten Detail Buku
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul dan Harga
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        bookModel.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    Text(
                      bookModel.price,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Author dan Publisher
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          context.push('/authors/${bookModel.author.id}'),
                      child: Text(
                        "By ${bookModel.author.name} · ",
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.push('/publishers/${bookModel.publisher.id}'),
                      child: Text(
                        bookModel.publisher.name,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Genre Tags
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: bookModel.genres
                      .map((genre) => StyledButton(
                            onPressed: () {
                              context.push('/genres/${genre.id}');
                            },
                            child: Text(genre.name),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 24),

                // Info Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    BookInfoCard(title: 'ISBN', value: bookModel.isbn),
                    BookInfoCard(title: 'Language', value: bookModel.language),
                    BookInfoCard(
                        title: 'Stock', value: '${bookModel.stock} units'),
                    BookInfoCard(
                      title: 'Published',
                      value: DateFormat('MMM d, y')
                          .format(bookModel.publicationDate),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Description
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  bookModel.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
