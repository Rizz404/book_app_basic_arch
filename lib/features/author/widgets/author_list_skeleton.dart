import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_tile.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AuthorListSkeleton extends StatelessWidget {
  final bool isSliver;
  final int itemCount;

  const AuthorListSkeleton({
    super.key,
    this.isSliver = false,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    final dummyAuthor = AuthorModel.dummy();

    final listView = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => AuthorTile(
        authorModel: dummyAuthor,
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
