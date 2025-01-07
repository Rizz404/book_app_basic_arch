import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_list_skeleton.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';

class InfiniteScrollPublisherList extends StatefulWidget {
  final List<PublisherModel> publishers;
  final bool isLoading;
  final bool isInitialLoading;
  final String? errorMessage;
  final String emptyMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(PublisherModel) onPublisherSelected;
  final ScrollController scrollController;
  final SliverGridDelegate gridDelegate;

  const InfiniteScrollPublisherList({
    super.key,
    required this.publishers,
    required this.isLoading,
    required this.isInitialLoading,
    required this.errorMessage,
    required this.emptyMessage,
    required this.onRetry,
    required this.onLoadMore,
    required this.onPublisherSelected,
    required this.scrollController,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.75,
    ),
  });

  @override
  State<InfiniteScrollPublisherList> createState() =>
      _InfiniteScrollPublisherListState();
}

class _InfiniteScrollPublisherListState
    extends State<InfiniteScrollPublisherList> {
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
      return const PublisherListSkeleton(
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

    if (widget.publishers.isEmpty) {
      return SliverFillRemaining(
        child: StyledEmptyData(message: widget.emptyMessage),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final publisher = widget.publishers[index];
              return PublisherTile(
                key: ValueKey(publisher.id),
                publisherModel: publisher,
                onTap: () => widget.onPublisherSelected(publisher),
              );
            },
            childCount: widget.publishers.length,
          ),
        ),
        if (widget.isLoading)
          const PublisherListSkeleton(
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
