import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PublisherListSkeleton extends StatelessWidget {
  final bool isSliver;
  final int itemCount;

  const PublisherListSkeleton({
    super.key,
    this.isSliver = false,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    final dummyPublisher = PublisherModel.dummy();

    final listView = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => PublisherTile(
        publisherModel: dummyPublisher,
      ),
      itemCount: itemCount,
    );

    final skeletonWidget = Skeletonizer(
      enabled: true,
      child: listView,
    );

    if (isSliver) {
      return SliverToBoxAdapter(child: skeletonWidget);
    }

    return skeletonWidget;
  }
}
