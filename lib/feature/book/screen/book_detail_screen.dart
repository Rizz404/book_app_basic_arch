import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/feature/book/widgets/book_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/feature/book/book_provider.dart';
import 'package:book_app_basic_arch/feature/book/enum_book_operation.dart';

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
      body: Consumer<BookProvider>(
        builder: (context, provider, _) {
          final isLoadingBook = provider.isLoading(EnumBookOperation.getById);
          final errorMessageBook = provider.getError(EnumBookOperation.getById);
          final book = provider.book;

          if (isLoadingBook) {
            return const Center(child: CircularProgressIndicator());
          }

          if (errorMessageBook != null) {
            return StyledErrorMessage(errorMessage: errorMessageBook);
          }

          if (book != null) {
            return BookDetailContent(bookModel: book);
          }

          return const Center(child: Text("No book found."));
        },
      ),
    );
  }
}
