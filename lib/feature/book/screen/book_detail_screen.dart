import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_card.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBookById(widget.bookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final bookProvider = context.read<BookProvider>();
          final book = bookProvider.book;

          if (book != null) {
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
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book not loaded yet.')),
            );
          }
        },
        child: Icon(Icons.edit),
      ),
      body: Consumer<BookProvider>(
        builder: (context, provider, _) {
          final isLoadingBook = provider.isLoading(EnumBookOperation.getById);
          final errorMessageBook = provider.getError(EnumBookOperation.getById);
          final book = provider.book;

          if (isLoadingBook) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageBook != null) {
            // Error State
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: $errorMessageBook",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.getBookById(widget.bookId),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (book != null) {
            return BookCard(
              bookModel: BookModel(
                id: book.id,
                sellerId: book.sellerId,
                title: book.title,
                genres: book.genres,
                bookPictures: book.bookPictures,
                description: book.description,
                status: book.status,
                slug: book.slug,
                isbn: book.isbn,
                stock: book.stock,
                price: book.price,
                fileUrl: book.fileUrl,
                publicationDate: book.publicationDate,
                author: book.author,
                seller: book.seller,
                publisher: book.publisher,
                language: book.language,
              ),
            );
          } else {
            // State kosong
            return const Center(
              child: Text("No book found."),
            );
          }
        },
      ),
    );
  }
}
