// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenreFilterModelImpl _$$GenreFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GenreFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      searchQuery: json['searchQuery'] as String?,
    );

Map<String, dynamic> _$$GenreFilterModelImplToJson(
        _$GenreFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'searchQuery': instance.searchQuery,
    };
