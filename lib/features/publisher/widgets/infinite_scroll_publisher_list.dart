import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_list_skeleton.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';

class InfiniteScrollPublisherList extends StatefulWidget {
  final List<PublisherModel> publishers;
  final bool isLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(PublisherModel) onPublisherSelected;
  final ScrollController scrollController;

  const InfiniteScrollPublisherList({
    super.key,
    required this.publishers,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onLoadMore,
    required this.onPublisherSelected,
    required this.scrollController,
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
    if (widget.isLoading) {
      return const PublisherListSkeleton();
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
      return const SliverFillRemaining(
        child: StyledEmptyData(message: 'No publishers found'),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        // Grid utama dengan data buku
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final publisher = widget.publishers[index];
              return PublisherTile(
                key: Key(publisher.id),
                publisherModel: publisher,
                onTap: () => widget.onPublisherSelected(publisher),
              );
            },
            childCount: widget.publishers.length,
          ),
        ),

        // Skeleton loader untuk pagination
        if (widget.isLoading)
          const PublisherListSkeleton(
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
