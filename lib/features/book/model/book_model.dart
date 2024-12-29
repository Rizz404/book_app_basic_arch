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
