// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorModelImpl _$$AuthorModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthorModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      biography: json['biography'] as String,
      birthDate: json['birthDate'] as String,
      deathDate: json['deathDate'] as String,
      profilePicture: json['profilePicture'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      followerCount: (json['followerCount'] as num).toInt(),
      isFollowedAuthor: json['isFollowedAuthor'] as bool? ?? false,
      originalFollowStatus: json['originalFollowStatus'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthorModelImplToJson(_$AuthorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'biography': instance.biography,
      'birthDate': instance.birthDate,
      'deathDate': instance.deathDate,
      'profilePicture': instance.profilePicture,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'followerCount': instance.followerCount,
      'isFollowedAuthor': instance.isFollowedAuthor,
      'originalFollowStatus': instance.originalFollowStatus,
    };

_$CreateAuthorModelImpl _$$CreateAuthorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateAuthorModelImpl(
      name: json['name'] as String,
      biography: json['biography'] as String,
      birthDate: json['birthDate'] as String,
      deathDate: json['deathDate'] as String,
      profilePicture: json['profilePicture'] as String,
    );

Map<String, dynamic> _$$CreateAuthorModelImplToJson(
        _$CreateAuthorModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'biography': instance.biography,
      'birthDate': instance.birthDate,
      'deathDate': instance.deathDate,
      'profilePicture': instance.profilePicture,
    };

_$UpdateAuthorModelImpl _$$UpdateAuthorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateAuthorModelImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      biography: json['biography'] as String?,
      birthDate: json['birthDate'] as String?,
      deathDate: json['deathDate'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$UpdateAuthorModelImplToJson(
        _$UpdateAuthorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'biography': instance.biography,
      'birthDate': instance.birthDate,
      'deathDate': instance.deathDate,
      'profilePicture': instance.profilePicture,
    };
