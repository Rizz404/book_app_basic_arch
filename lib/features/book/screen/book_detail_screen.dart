import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;

  const BookDetailScreen({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookProvider = context.read<BookProvider>();

      bookProvider.getBookById(bookId);

      bookProvider.updateFilterForSpecificScreen(
        BookScreenType.books,
        bookProvider
            .getFilterForSpecificScreen(BookScreenType.books)
            .copyWith(limit: 20),
      );

      bookProvider.getBooks(screen: BookScreenType.books);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text('Detail'),
        ),
        builder: (builder, controller) {
          return [
            SliverToBoxAdapter(
              child: Consumer<BookProvider>(
                builder: (context, provider, _) {
                  final book = provider.book;
                  final isLoading =
                      provider.isLoading(BookOperationType.getBookById);
                  final errorMessage =
                      provider.getError(BookOperationType.getBookById);

                  if (isLoading) {
                    return const StyledLoadingState();
                  }

                  if (errorMessage != null) {
                    return StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () =>
                          context.read<BookProvider>().getBookById(bookId),
                    );
                  }

                  if (book == null) {
                    return const StyledEmptyData(message: 'No books found');
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // * Picture
                      ClipRRect(
                        child: Image.network(
                          book.bookPictures![0].url,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 250,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://i.pinimg.com/236x/64/2e/96/642e9610c5c587767430bf6a9deeff7c.jpg',
                              fit: BoxFit.contain,
                            );
                          },
                          cacheWidth: 300,
                          cacheHeight: 300,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // * Title
                            Text(
                              book.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),

                            // * Author
                            GestureDetector(
                              onTap: () => context.push(
                                '/authors/${book.author.id}',
                              ),
                              child: Text(
                                'By: ${book.author.name}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // * Description title
                            Text(
                              'About this book',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),

                            // * Description content
                            Text(
                              book.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 24),

                            // * Suggestion title
                            Text(
                              'Suggestion',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // * Suggestions Grid dalam Sliver terpisah
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = bookProvider
                      .getBooksForSpecificScreen(BookScreenType.books);
                  final isLoading =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessage =
                      bookProvider.getError(BookOperationType.getBooks);

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (errorMessage != null) {
                          return Center(
                            child: TextButton(
                              onPressed: () => bookProvider.getBooks(
                                screen: BookScreenType.books,
                              ),
                              child: const Text('Retry'),
                            ),
                          );
                        }
                        if (books.isEmpty) {
                          return const Center(
                              child: Text('No suggestions available'));
                        }
                        return BookCard(
                          bookModel: books[index],
                          onTap: () =>
                              context.push('/books/${books[index].id}'),
                        );
                      },
                      childCount: books.isEmpty ? 1 : books.length,
                    ),
                  );
                },
              ),
            ),
          ];
        },
      ),
    );
  }
}
