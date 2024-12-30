import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_filter_model.freezed.dart';
part 'author_filter_model.g.dart';

@freezed
class AuthorFilterModel with _$AuthorFilterModel {
  const factory AuthorFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
    String? birthDateRange,
    String? deathDateRange,
  }) = _AuthorFilterModel;

  factory AuthorFilterModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorFilterModelFromJson(json);
}
