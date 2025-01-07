import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookGridSkeleton extends StatelessWidget {
  final bool isSliver;
  final int itemCount;

  const BookGridSkeleton({
    super.key,
    this.isSliver = false,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    final dummyBook = BookModel.dummy();

    final gridView = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => BookCard(
        bookModel: dummyBook,
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
