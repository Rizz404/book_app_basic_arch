import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';

class InfiniteScrollBookGrid extends StatefulWidget {
  final List<BookModel> books;
  final bool isLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(BookModel) onBookSelected;
  final ScrollController scrollController;

  const InfiniteScrollBookGrid({
    super.key,
    required this.books,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
    required this.onLoadMore,
    required this.onBookSelected,
    required this.scrollController,
  });

  @override
  State<InfiniteScrollBookGrid> createState() => _InfiniteScrollBookGridState();
}

class _InfiniteScrollBookGridState extends State<InfiniteScrollBookGrid> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && !widget.isLoading) {
      widget.onLoadMore();
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    // Load more when user reaches 80% of the list
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.books.isEmpty) {
      if (widget.isLoading) {
        return const SliverFillRemaining(
          child: StyledLoadingState(),
        );
      }

      if (widget.errorMessage != null) {
        return SliverFillRemaining(
          child: StyledErrorMessage(
            errorMessage: widget.errorMessage!,
            onRetry: widget.onRetry,
          ),
        );
      }

      return const SliverFillRemaining(
        child: StyledEmptyData(message: 'No books found'),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Tampilkan loading indicator di akhir list
          if (index == widget.books.length) {
            return widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox();
          }

          final book = widget.books[index];
          return BookCard(
            bookModel: book,
            onTap: () => widget.onBookSelected(book),
          );
        },
        childCount: widget.books.length + (widget.isLoading ? 1 : 0),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
