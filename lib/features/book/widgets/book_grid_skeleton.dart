import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookGridSkeleton extends StatelessWidget {
  final bool isSliver;
  const BookGridSkeleton({super.key, this.isSliver = true});

  @override
  Widget build(BuildContext context) {
    final dummyBook = BookModel(
        id: '',
        sellerId: '',
        title: '',
        genres: [
          const GenreModel(id: 'id', name: ''),
        ],
        description: '',
        status: '',
        slug: '',
        isbn: '',
        stock: 0,
        price: '',
        publicationDate: DateTime(2025),
        author: const BookAuthorModel(id: '', name: ''),
        seller: const BookSellerModel(id: '', username: '', email: ''),
        publisher:
            const BookPublisherModel(id: '', name: '', email: '', website: ['']),
        language: '',
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
        wishlistCount: 0,
        isWishlisted: false,
        bookPictures: [
          const BookPictureModel(
            id: '',
            url:
                'https://i.pinimg.com/236x/64/2e/96/642e9610c5c587767430bf6a9deeff7c.jpg',
          ),
        ]);

    final gridView = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => BookCard(bookModel: dummyBook),
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
