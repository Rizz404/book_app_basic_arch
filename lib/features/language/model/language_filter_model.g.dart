// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageFilterModelImpl _$$LanguageFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LanguageFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$LanguageFilterModelImplToJson(
        _$LanguageFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
