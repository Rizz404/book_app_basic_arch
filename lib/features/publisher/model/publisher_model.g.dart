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
      picture: json['picture'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      followerCount: (json['followerCount'] as num).toInt(),
      isFollowedPublisher: json['isFollowedPublisher'] as bool? ?? false,
      originalFollowStatus: json['originalFollowStatus'] as bool? ?? false,
    );

Map<String, dynamic> _$$PublisherModelImplToJson(
        _$PublisherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
      'picture': instance.picture,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'followerCount': instance.followerCount,
      'isFollowedPublisher': instance.isFollowedPublisher,
      'originalFollowStatus': instance.originalFollowStatus,
    };

_$CreatePublisherModelImpl _$$CreatePublisherModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePublisherModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      website:
          (json['website'] as List<dynamic>).map((e) => e as String).toList(),
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$$CreatePublisherModelImplToJson(
        _$CreatePublisherModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
      'picture': instance.picture,
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
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$UpdatePublisherModelImplToJson(
        _$UpdatePublisherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'website': instance.website,
      'picture': instance.picture,
    };
