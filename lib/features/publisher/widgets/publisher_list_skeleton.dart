import 'package:book_app_basic_arch/features/publisher/widgets/publisher_tile.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';

class PublisherListSkeleton extends StatelessWidget {
  final bool isSliver;

  const PublisherListSkeleton({super.key, this.isSliver = true});

  @override
  Widget build(BuildContext context) {
    final dummyPublisher = PublisherModel(
      id: '',
      name: BoneMock.name,
      email: BoneMock.email,
      description: BoneMock.paragraph,
      website: [BoneMock.name],
      picture: BoneMock.time,
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      followerCount: 0,
    );

    if (isSliver) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Skeletonizer(
              enabled: true,
              child: PublisherTile(publisherModel: dummyPublisher),
            );
          },
          childCount: 10, // Jumlah item dummy
        ),
      );
    }

    return SizedBox(
      height: 300, // Sesuaikan tinggi maksimal
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Skeletonizer(
            enabled: true,
            child: PublisherTile(publisherModel: dummyPublisher),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
