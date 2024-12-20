// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiMeta _$ApiMetaFromJson(Map<String, dynamic> json) => ApiMeta(
      version: json['version'] as String,
      timestamp: json['timestamp'] as String,
      pagination: json['pagination'] == null
          ? null
          : ApiPagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiMetaToJson(ApiMeta instance) => <String, dynamic>{
      'version': instance.version,
      'timestamp': instance.timestamp,
      'pagination': instance.pagination,
    };
