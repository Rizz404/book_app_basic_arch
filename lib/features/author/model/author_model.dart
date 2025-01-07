import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_model.freezed.dart';
part 'author_model.g.dart';

@freezed
class AuthorModel with _$AuthorModel {
  const factory AuthorModel({
    required String id,
    required String name,
    required String biography,
    required String birthDate,
    required String deathDate,
    required String profilePicture,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int followerCount,
    @Default(false) bool isFollowedAuthor,
    @Default(false) bool originalFollowStatus,
  }) = _AuthorModel;

  factory AuthorModel.dummy() => AuthorModel(
        id: '',
        name: 'Dummy name',
        biography: 'Dummy biography',
        birthDate: 'Dummy birthDate',
        deathDate: 'Dummy deathDate',
        profilePicture: 'https://via.placeholder.com/150',
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
        followerCount: 0,
      );

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
}

@freezed
class CreateAuthorModel with _$CreateAuthorModel {
  const factory CreateAuthorModel({
    required String name,
    required String biography,
    required String birthDate,
    required String deathDate,
    required String profilePicture,
  }) = _CreateAuthorModel;

  factory CreateAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAuthorModelFromJson(json);
}

@freezed
class UpdateAuthorModel with _$UpdateAuthorModel {
  const factory UpdateAuthorModel({
    required String id,
    String? name,
    String? biography,
    String? birthDate,
    String? deathDate,
    String? profilePicture,
  }) = _UpdateAuthorModel;

  factory UpdateAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateAuthorModelFromJson(json);
}
