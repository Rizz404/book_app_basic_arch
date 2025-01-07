import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/widgets/genre_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GenreGridSkeleton extends StatelessWidget {
  final bool isSliver;
  final int itemCount;

  const GenreGridSkeleton({
    super.key,
    this.isSliver = false,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    final dummyGenre = GenreModel.dummy();

    final gridView = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => GenreCard(
        genreModel: dummyGenre,
      ),
      itemCount: itemCount,
    );

    final skeletonWidget = Skeletonizer(
      enabled: true,
      child: gridView,
    );

    if (isSliver) {
      return SliverToBoxAdapter(child: skeletonWidget);
    }

    return skeletonWidget;
  }
}
