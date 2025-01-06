import 'package:book_app_basic_arch/features/author/widgets/author_tile.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';

class AuthorListSkeleton extends StatelessWidget {
  final bool isSliver;

  const AuthorListSkeleton({super.key, this.isSliver = true});

  @override
  Widget build(BuildContext context) {
    final dummyAuthor = AuthorModel(
      id: '',
      name: BoneMock.name,
      biography: BoneMock.paragraph,
      birthDate: BoneMock.time,
      deathDate: BoneMock.time,
      profilePicture: BoneMock.name,
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
              child: AuthorTile(authorModel: dummyAuthor),
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
            child: AuthorTile(authorModel: dummyAuthor),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
