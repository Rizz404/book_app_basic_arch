import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_card.dart';

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
      return StyledLoadingState();
    }

    if (errorMessageBooks != null) {
      return StyledErrorMessage(
        errorMessage: errorMessageBooks,
        onRetry: provider.getBooks,
      );
    }

    if (books.isEmpty) {
      return StyledEmptyData(message: 'No books found');
    }

    return _buildBookList(context, books);
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
            context.go('/books/${book.id}');
          },
        );
      },
      itemCount: books.length,
    );
  }
}
