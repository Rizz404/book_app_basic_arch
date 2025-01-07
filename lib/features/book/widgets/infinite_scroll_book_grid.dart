import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_grid_skeleton.dart';
import 'package:flutter/material.dart';

class InfiniteScrollBookGrid extends StatefulWidget {
  final List<BookModel> books;
  final bool isLoading;
  final bool isInitialLoading;
  final String? errorMessage;
  final String emptyMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(BookModel) onBookSelected;
  final ScrollController scrollController;
  final SliverGridDelegate gridDelegate;

  const InfiniteScrollBookGrid({
    super.key,
    required this.books,
    required this.isLoading,
    required this.isInitialLoading,
    required this.errorMessage,
    required this.emptyMessage,
    required this.onRetry,
    required this.onLoadMore,
    required this.onBookSelected,
    required this.scrollController,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.75,
    ),
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
    if (widget.isInitialLoading) {
      return const BookGridSkeleton(
        isSliver: true,
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

    if (widget.books.isEmpty) {
      return SliverFillRemaining(
        child: StyledEmptyData(message: widget.emptyMessage),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverGrid(
          gridDelegate: widget.gridDelegate,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final book = widget.books[index];
              return BookCard(
                key: ValueKey(book.id),
                bookModel: book,
                onTap: () => widget.onBookSelected(book),
              );
            },
            childCount: widget.books.length,
          ),
        ),
        if (widget.isLoading)
          const BookGridSkeleton(
            itemCount: 4,
            isSliver: true,
          ),
      ],
    );
  }
}
