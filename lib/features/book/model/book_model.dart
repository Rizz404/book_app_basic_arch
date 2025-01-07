import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required String id,
    required String sellerId,
    required String title,
    required List<GenreModel> genres,
    List<BookPictureModel>? bookPictures,
    required String description,
    required String status,
    required String slug,
    required String isbn,
    required int stock,
    required String price,
    String? fileUrl,
    required DateTime publicationDate,
    required BookAuthorModel author,
    required BookSellerModel seller,
    required BookPublisherModel publisher,
    required String language,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int wishlistCount,
    required bool isWishlisted,
    @Default(false) bool originalWishlistStatus,
  }) = _BookModel;

  // Tambahkan factory constructor untuk dummy
  factory BookModel.dummy() => BookModel(
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

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    required String id,
    required String name,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}

@freezed
class BookPictureModel with _$BookPictureModel {
  const factory BookPictureModel({
    required String id,
    required String url,
    @Default(false) bool isCover,
  }) = _BookPictureModel;

  factory BookPictureModel.fromJson(Map<String, dynamic> json) =>
      _$BookPictureModelFromJson(json);
}

@freezed
class BookAuthorModel with _$BookAuthorModel {
  const factory BookAuthorModel({
    required String id,
    required String name,
  }) = _BookAuthorModel;

  factory BookAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$BookAuthorModelFromJson(json);
}

@freezed
class BookSellerModel with _$BookSellerModel {
  const factory BookSellerModel({
    required String id,
    required String username,
    required String email,
    @Default(false) bool isVerified,
    String? profilePicture,
  }) = _BookSellerModel;

  factory BookSellerModel.fromJson(Map<String, dynamic> json) =>
      _$BookSellerModelFromJson(json);
}

@freezed
class BookPublisherModel with _$BookPublisherModel {
  const factory BookPublisherModel({
    required String id,
    required String name,
    required String email,
    required List<String> website,
  }) = _BookPublisherModel;

  factory BookPublisherModel.fromJson(Map<String, dynamic> json) =>
      _$BookPublisherModelFromJson(json);
}

@freezed
class CreateBookModel with _$CreateBookModel {
  const factory CreateBookModel({
    required String title,
    required List<String> genreIds,
    required String description,
    required String isbn,
    required int stock,
    required String price,
    String? fileUrl,
    required DateTime publicationDate,
    required String authorId,
    required String publisherId,
    required String language,
  }) = _CreateBookModel;

  factory CreateBookModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBookModelFromJson(json);
}

@freezed
class UpdateBookModel with _$UpdateBookModel {
  const factory UpdateBookModel({
    required String id,
    String? title,
    List<String>? genreIds,
    String? description,
    String? isbn,
    int? stock,
    String? price,
    String? fileUrl,
    DateTime? publicationDate,
    String? authorId,
    String? publisherId,
    String? language,
  }) = _UpdateBookModel;

  factory UpdateBookModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookModelFromJson(json);
}
