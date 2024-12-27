// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublisherModelImpl _$$PublisherModelImplFromJson(Map<String, dynamic> json) =>
    _$PublisherModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      website:
          (json['website'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PublisherModelImplToJson(
        _$PublisherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CreatePublisherModelImpl _$$CreatePublisherModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePublisherModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      website:
          (json['website'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CreatePublisherModelImplToJson(
        _$CreatePublisherModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
    };

_$UpdatePublisherModelImpl _$$UpdatePublisherModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePublisherModelImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      website:
          (json['website'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UpdatePublisherModelImplToJson(
        _$UpdatePublisherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
    };
