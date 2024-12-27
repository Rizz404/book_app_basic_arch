import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';

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
        title: const Text(
          "Books",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => bookProvider.getBooks(),
        child: Consumer<BookProvider>(
          builder: (context, provider, _) {
            return _buildBookContent(context, provider);
          },
        ),
      ),
    );
  }

  Widget _buildBookContent(BuildContext context, BookProvider provider) {
    final isLoadingBooks = provider.isLoading(EnumBookOperation.getAll);
    final errorMessageBooks = provider.getError(EnumBookOperation.getAll);
    final books = provider.books;

    if (isLoadingBooks) {
      return const StyledLoadingState();
    }

    if (errorMessageBooks != null) {
      return StyledErrorMessage(
        errorMessage: errorMessageBooks,
        onRetry: provider.getBooks,
      );
    }

    if (books.isEmpty) {
      return const StyledEmptyData(message: 'No books found');
    }

    return _buildBookList(context, books);
  }

  Widget _buildBookList(BuildContext context, List<BookModel> books) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85, // Rasio aspek kartu diubah agar lebih tinggi
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            bookModel: book,
            onTap: () => context.go('/books/${book.id}'),
          );
        },
        itemCount: books.length,
      ),
    );
  }
}
