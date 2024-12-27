// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageModelImpl _$$LanguageModelImplFromJson(Map<String, dynamic> json) =>
    _$LanguageModelImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$LanguageModelImplToJson(_$LanguageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

_$CreateLanguageModelImpl _$$CreateLanguageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateLanguageModelImpl(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CreateLanguageModelImplToJson(
        _$CreateLanguageModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$UpdateLanguageModelImpl _$$UpdateLanguageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateLanguageModelImpl(
      id: json['id'] as String,
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$UpdateLanguageModelImplToJson(
        _$UpdateLanguageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
