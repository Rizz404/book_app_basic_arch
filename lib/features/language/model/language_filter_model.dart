import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_filter_model.freezed.dart';
part 'language_filter_model.g.dart';

@freezed
class LanguageFilterModel with _$LanguageFilterModel {
  const factory LanguageFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
  }) = _LanguageFilterModel;

  factory LanguageFilterModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageFilterModelFromJson(json);
}
