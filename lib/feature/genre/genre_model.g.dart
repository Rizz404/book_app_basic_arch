// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => GenreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CreateGenreModel _$CreateGenreModelFromJson(Map<String, dynamic> json) =>
    CreateGenreModel(
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreateGenreModelToJson(CreateGenreModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

UpdateGenreModel _$UpdateGenreModelFromJson(Map<String, dynamic> json) =>
    UpdateGenreModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdateGenreModelToJson(UpdateGenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
