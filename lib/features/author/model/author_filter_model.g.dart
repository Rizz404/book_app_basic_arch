// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorFilterModelImpl _$$AuthorFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthorFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      birthDateRange: json['birthDateRange'] as String?,
      deathDateRange: json['deathDateRange'] as String?,
    );

Map<String, dynamic> _$$AuthorFilterModelImplToJson(
        _$AuthorFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'birthDateRange': instance.birthDateRange,
      'deathDateRange': instance.deathDateRange,
    };
