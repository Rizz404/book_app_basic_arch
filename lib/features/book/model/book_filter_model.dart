import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_filter_model.freezed.dart';
part 'book_filter_model.g.dart';

@freezed
class BookFilterModel with _$BookFilterModel {
  const factory BookFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
    String? sellerId,
    String? language,
    String? genreId,
  }) = _BookFilterModel;

  factory BookFilterModel.fromJson(Map<String, dynamic> json) =>
      _$BookFilterModelFromJson(json);
}
