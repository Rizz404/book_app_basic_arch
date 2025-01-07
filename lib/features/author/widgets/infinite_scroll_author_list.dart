import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_list_skeleton.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_tile.dart';
import 'package:flutter/material.dart';

class InfiniteScrollAuthorList extends StatefulWidget {
  final List<AuthorModel> authors;
  final bool isLoading;
  final bool isInitialLoading;
  final String? errorMessage;
  final String emptyMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(AuthorModel) onAuthorSelected;
  final ScrollController scrollController;
  final SliverGridDelegate gridDelegate;

  const InfiniteScrollAuthorList({
    super.key,
    required this.authors,
    required this.isLoading,
    required this.isInitialLoading,
    required this.errorMessage,
    required this.emptyMessage,
    required this.onRetry,
    required this.onLoadMore,
    required this.onAuthorSelected,
    required this.scrollController,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.75,
    ),
  });

  @override
  State<InfiniteScrollAuthorList> createState() =>
      _InfiniteScrollAuthorListState();
}

class _InfiniteScrollAuthorListState extends State<InfiniteScrollAuthorList> {
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
      return const AuthorListSkeleton(
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

    if (widget.authors.isEmpty) {
      return SliverFillRemaining(
        child: StyledEmptyData(message: widget.emptyMessage),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final author = widget.authors[index];
              return AuthorTile(
                key: ValueKey(author.id),
                authorModel: author,
                onTap: () => widget.onAuthorSelected(author),
              );
            },
            childCount: widget.authors.length,
          ),
        ),
        if (widget.isLoading)
          const AuthorListSkeleton(
            itemCount: 3,
            isSliver: true,
          ),
      ],
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
