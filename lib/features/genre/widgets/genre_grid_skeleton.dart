import 'package:book_app_basic_arch/features/genre/widgets/genre_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';

class GenreGridSkeleton extends StatelessWidget {
  final bool isSliver;
  const GenreGridSkeleton({super.key, this.isSliver = true});

  @override
  Widget build(BuildContext context) {
    final dummyGenre = GenreModel(
      id: '',
      name: BoneMock.title,
      description: BoneMock.paragraph,
      picture: BoneMock.title,
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      followerCount: 0,
    );

    final gridView = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => GenreCard(genreModel: dummyGenre),
      itemCount: 10, // Hanya menampilkan 2 skeleton untuk pagination
    );

    if (isSliver) {
      return SliverToBoxAdapter(
        child: Skeletonizer(
          enabled: true,
          child: gridView,
        ),
      );
    }

    return Skeletonizer(
      enabled: true,
      child: gridView,
    );
  }
}
