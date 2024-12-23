import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/feature/book/screen/book_detail_screen.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_card.dart';
import 'package:book_app_basic_arch/feature/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookProvider.getBooks();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      // todo: Benerin refresh indicator
      body: RefreshIndicator(
        onRefresh: () => bookProvider.getBooks(),
        child: Column(
          children: [
            StyledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Text('To profile'),
            ),
            Expanded(
              child: Consumer<BookProvider>(
                builder: (context, provider, _) {
                  return _buildBookContent(context, provider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookContent(BuildContext context, BookProvider provider) {
    final isLoadingBooks = provider.isLoading(EnumBookOperation.getAll);
    final errorMessageBooks = provider.getError(EnumBookOperation.getAll);
    final books = provider.books;

    if (isLoadingBooks) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessageBooks != null) {
      return _buildErrorState(errorMessageBooks, provider);
    }

    if (books.isEmpty) {
      return const Center(
        child: Text("No books found."),
      );
    }

    return _buildBookList(context, books);
  }

  Widget _buildErrorState(String errorMessage, BookProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error: $errorMessage",
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => provider.getBooks(),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(BuildContext context, List<BookModel> books) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          bookModel: book,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                  bookId: book.id,
                ),
              ),
            );
          },
        );
      },
      itemCount: books.length,
    );
  }
}
