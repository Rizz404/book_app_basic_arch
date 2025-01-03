// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_filter_model.freezed.dart';
part 'book_filter_model.g.dart';

enum BookStatus {
  AVAILABLE,
  SOLD,
  ARCHIVED,
}

@freezed
class BookFilterModel with _$BookFilterModel {
  const factory BookFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
    BookStatus? status,
    String? sellerId,
    String? genreId,
    String? authorId,
    String? publisherId,
    String? publicationDateRange,
    String? language,
    String? searchQuery, // * Untuk menyimpan query pencarian
  }) = _BookFilterModel;

  factory BookFilterModel.fromJson(Map<String, dynamic> json) =>
      _$BookFilterModelFromJson(json);
}
