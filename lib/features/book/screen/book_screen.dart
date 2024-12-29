import 'package:book_app_basic_arch/core/helpers/enum_screen_type.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().getBooks(screen: ScreenType.books);
    });

    return StyledScreenLayoutBuilder(
      sliverAppBar: StyledSliverAppBar(
        title: StyledSearchBarPlaceholder(),
      ),
      builder: (builder, controller) {
        return [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books =
                    bookProvider.getBooksForSpecificScreen(ScreenType.books);
                final isLoading =
                    bookProvider.isLoading(EnumBookOperation.getAll);
                final errorMessage =
                    bookProvider.getError(EnumBookOperation.getAll);

                return SliverToBoxAdapter(
                  child: BookGrid(
                    books: books,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onRetry: () => bookProvider.getBooks(
                      screen: ScreenType.books,
                    ),
                    onBookSelected: (book) {
                      context.push('/books/${book.id}');
                    },
                  ),
                );
              },
            ),
          ),
        ];
      },
    );
  }
}
