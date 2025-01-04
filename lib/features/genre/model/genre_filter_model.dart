import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_filter_model.freezed.dart';
part 'genre_filter_model.g.dart';

@freezed
class GenreFilterModel with _$GenreFilterModel {
  const factory GenreFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
    String? searchQuery, // * Untuk menyimpan query pencarian
  }) = _GenreFilterModel;

  factory GenreFilterModel.fromJson(Map<String, dynamic> json) =>
      _$GenreFilterModelFromJson(json);
}
