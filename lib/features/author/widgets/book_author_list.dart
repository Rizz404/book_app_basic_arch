import 'package:book_app_basic_arch/core/helpers/enum_screen_type.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookAuthorList extends StatelessWidget {
  final ScrollController scrollController;

  const BookAuthorList({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, _) {
        return _buildBookListContent(context, provider);
      },
    );
  }

  Widget _buildBookListContent(BuildContext context, BookProvider provider) {
    final isLoadingBooks = provider.isLoading(EnumBookOperation.getAll);
    final errorMessageBooks = provider.getError(EnumBookOperation.getAll);
    final books = provider.getBooksForSpecificScreen(ScreenType.authorDetail);

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

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          bookModel: book,
          onTap: () => context.push('/books/${book.id}'),
        );
      },
      itemCount: books.length,
    );
  }
}
