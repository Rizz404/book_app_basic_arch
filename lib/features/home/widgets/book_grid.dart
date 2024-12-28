import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/home/widgets/book_card.dart';
import 'package:flutter/material.dart';

// todo: Nanti pindahin di folder widget books
class BookGrid extends StatelessWidget {
  final List<BookModel> books;
  final bool isLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function(BookModel) onBookSelected;

  const BookGrid({
    super.key,
    required this.books,
    required this.isLoading,
    required this.onBookSelected,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const StyledLoadingState();
    }

    if (errorMessage != null) {
      return StyledErrorMessage(
        errorMessage: errorMessage!,
        onRetry: onRetry,
      );
    }

    if (books.isEmpty) {
      return const StyledEmptyData(message: 'No books found');
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          bookModel: book,
          onTap: () => onBookSelected(book),
        );
      },
      itemCount: books.length,
    );
  }
}
