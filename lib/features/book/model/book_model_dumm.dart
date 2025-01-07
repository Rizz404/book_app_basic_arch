import 'package:book_app_basic_arch/features/book/model/book_model.dart';

extension BookModelDummy on BookModel {
  static BookModel dummy() {
    return BookModel(
      id: '',
      sellerId: '',
      title: 'Dummy Book Title',
      genres: [
        const GenreModel(id: 'dummy-id', name: 'Dummy Genre'),
      ],
      description: 'Dummy description',
      status: 'active',
      slug: 'dummy-book',
      isbn: '1234567890',
      stock: 10,
      price: '99.99',
      publicationDate: DateTime(2025),
      author: const BookAuthorModel(id: 'dummy-id', name: 'Dummy Author'),
      seller: const BookSellerModel(
        id: 'dummy-id',
        username: 'dummyseller',
        email: 'dummy@email.com',
      ),
      publisher: const BookPublisherModel(
        id: 'dummy-id',
        name: 'Dummy Publisher',
        email: 'publisher@email.com',
        website: ['https://dummy.com'],
      ),
      language: 'English',
      createdAt: DateTime(2025),
      updatedAt: DateTime(2025),
      wishlistCount: 0,
      isWishlisted: false,
      bookPictures: [
        const BookPictureModel(
          id: 'dummy-id',
          url: 'https://via.placeholder.com/150',
          isCover: true,
        ),
      ],
    );
  }
}
