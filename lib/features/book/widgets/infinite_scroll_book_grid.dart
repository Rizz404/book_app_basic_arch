import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid_skeleton.dart';
import 'package:flutter/material.dart';

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
    required this.errorMessage,
    required this.onRetry,
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
    if (!widget.scrollController.hasClients) {
      return false;
    }
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const BookGridSkeleton();
    }

    if (widget.errorMessage != null) {
      return SliverFillRemaining(
        child: StyledErrorMessage(
          errorMessage: widget.errorMessage!,
          onRetry: widget.onRetry,
        ),
      );
    }

    if (widget.books.isEmpty) {
      return const SliverFillRemaining(
        child: StyledEmptyData(message: 'No books found'),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        // Grid utama dengan data buku
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final book = widget.books[index];
              return BookCard(
                key: Key(book.id),
                bookModel: book,
                onTap: () => widget.onBookSelected(book),
              );
            },
            childCount: widget.books.length,
          ),
        ),

        // Skeleton loader untuk pagination
        if (widget.isLoading) const BookGridSkeleton(),
      ],
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
