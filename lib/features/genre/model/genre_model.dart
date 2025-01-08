import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    required String id,
    required String name,
    required String description,
    required String picture,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int followerCount,
    @Default(false) bool isFollowedGenre,
    @Default(false) bool originalFollowStatus,
  }) = _GenreModel;

  factory GenreModel.dummy() => GenreModel(
        id: '',
        name: 'dummy name',
        description: 'dummy description',
        picture: 'https://via.placeholder.com/150',
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
        followerCount: 0,
      );

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}

@freezed
class CreateGenreModel with _$CreateGenreModel {
  const factory CreateGenreModel({
    required String name,
    required String description,
    required String? picture,
  }) = _CreateGenreModel;

  factory CreateGenreModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGenreModelFromJson(json);
}

@freezed
class UpdateGenreModel with _$UpdateGenreModel {
  const factory UpdateGenreModel({
    required String id,
    String? name,
    String? description,
    String? picture,
  }) = _UpdateGenreModel;

  factory UpdateGenreModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateGenreModelFromJson(json);
}
