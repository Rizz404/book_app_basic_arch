import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookSearchResultScreen extends StatefulWidget {
  final String query;

  const BookSearchResultScreen({
    super.key,
    required this.query,
  });

  @override
  State<BookSearchResultScreen> createState() => _BookSearchResultScreenState();
}

class _BookSearchResultScreenState extends State<BookSearchResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().searchBooksByTitle(title: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          title: Text('Hasil Pencarian: ${widget.query}'),
        ),
        builder: (builder, controller) {
          return [
            Consumer<BookProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading(BookOperationType.searchBooks)) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final book = provider.searchedBooks[index];
                        return BookCard(
                          bookModel: book,
                          onTap: () => context.push('/books/${book.id}'),
                        );
                      },
                      childCount: provider.searchedBooks.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }
}
