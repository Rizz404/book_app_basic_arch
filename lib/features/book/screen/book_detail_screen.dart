import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_detail_skeleton.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookId;

  const BookDetailScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Future<void> _fetchData() async {
    final bookProvider = context.read<BookProvider>();

    await bookProvider.getBookById(widget.bookId);
    await bookProvider.getBooks(screen: BookScreenType.bookDetail);
  }

  @override
  void didUpdateWidget(covariant BookDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bookId != widget.bookId) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _fetchData();
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _fetchData(),
      child: BaseScaffold(
        body: StyledScreenLayoutBuilder(
          sliverAppBar: const StyledSliverAppBar(
            title: Text('Detail'),
          ),
          builder: (builder, controller) {
            return [
              SliverToBoxAdapter(
                child: Consumer<BookProvider>(
                  builder: (context, provider, _) {
                    final book = provider.getBookByIdFromCache(widget.bookId);
                    final isLoading =
                        provider.isLoading(BookOperationType.getBookById);
                    final errorMessage =
                        provider.getError(BookOperationType.getBookById);

                    if (isLoading) {
                      return const BookDetailSkeleton();
                    }

                    if (errorMessage != null) {
                      return StyledErrorMessage(
                        errorMessage: errorMessage,
                        onRetry: () => context
                            .read<BookProvider>()
                            .getBookById(widget.bookId),
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
                              const SizedBox(height: 4),

                              // * Publisher
                              GestureDetector(
                                onTap: () => context.push(
                                  '/publishers/${book.publisher.id}',
                                ),
                                child: Text(
                                  'Publish by: ${book.publisher.name}',
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
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = bookProvider
                      .getBooksForSpecificScreen(BookScreenType.bookDetail);
                  final isLoadingBooks =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessageBooks =
                      bookProvider.getError(BookOperationType.getBooks);

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoadingBooks,
                      errorMessage: errorMessageBooks,
                      emptyMessage: 'Book is empty, try to add one admin!!',
                      scrollController: controller,
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      isInitialLoading: bookProvider.isInitialLoad(
                        BookScreenType.bookDetail,
                      ),
                      onLoadMore: () =>
                          bookProvider.loadMoreBooks(BookScreenType.bookDetail),
                      onRetry: () => bookProvider.getBooks(
                        screen: BookScreenType.bookDetail,
                      ),
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ),
    );
  }
}
