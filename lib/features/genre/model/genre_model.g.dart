// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenreModelImpl _$$GenreModelImplFromJson(Map<String, dynamic> json) =>
    _$GenreModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      followerCount: (json['followerCount'] as num).toInt(),
      isFollowedGenre: json['isFollowedGenre'] as bool? ?? false,
      originalFollowStatus: json['originalFollowStatus'] as bool? ?? false,
    );

Map<String, dynamic> _$$GenreModelImplToJson(_$GenreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'picture': instance.picture,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'followerCount': instance.followerCount,
      'isFollowedGenre': instance.isFollowedGenre,
      'originalFollowStatus': instance.originalFollowStatus,
    };

_$CreateGenreModelImpl _$$CreateGenreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateGenreModelImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$CreateGenreModelImplToJson(
        _$CreateGenreModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'picture': instance.picture,
    };

_$UpdateGenreModelImpl _$$UpdateGenreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateGenreModelImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$UpdateGenreModelImplToJson(
        _$UpdateGenreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'picture': instance.picture,
    };
