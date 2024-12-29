// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookFilterModelImpl _$$BookFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      sellerId: json['sellerId'] as String?,
      language: json['language'] as String?,
      genreId: json['genreId'] as String?,
    );

Map<String, dynamic> _$$BookFilterModelImplToJson(
        _$BookFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'sellerId': instance.sellerId,
      'language': instance.language,
      'genreId': instance.genreId,
    };
