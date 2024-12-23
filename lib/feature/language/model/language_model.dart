import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_model.freezed.dart';
part 'language_model.g.dart';

@freezed
class LanguageModel with _$LanguageModel {
  const factory LanguageModel({
    required String id,
    required String code,
    required String name,
  }) = _LanguageModel;

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
}

@freezed
class CreateLanguageModel with _$CreateLanguageModel {
  const factory CreateLanguageModel({
    required String code,
    required String name,
  }) = _CreateLanguageModel;

  factory CreateLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$CreateLanguageModelFromJson(json);
}

@freezed
class UpdateLanguageModel with _$UpdateLanguageModel {
  const factory UpdateLanguageModel({
    required String id,
    String? code,
    String? name,
  }) = _UpdateLanguageModel;

  factory UpdateLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateLanguageModelFromJson(json);
}
