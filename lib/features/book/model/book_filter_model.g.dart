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
      status: $enumDecodeNullable(_$BookStatusEnumMap, json['status']),
      sellerId: json['sellerId'] as String?,
      genreId: json['genreId'] as String?,
      authorId: json['authorId'] as String?,
      publisherId: json['publisherId'] as String?,
      publicationDateRange: json['publicationDateRange'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$$BookFilterModelImplToJson(
        _$BookFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'status': _$BookStatusEnumMap[instance.status],
      'sellerId': instance.sellerId,
      'genreId': instance.genreId,
      'authorId': instance.authorId,
      'publisherId': instance.publisherId,
      'publicationDateRange': instance.publicationDateRange,
      'language': instance.language,
    };

const _$BookStatusEnumMap = {
  BookStatus.AVAILABLE: 'AVAILABLE',
  BookStatus.SOLD: 'SOLD',
  BookStatus.ARCHIVED: 'ARCHIVED',
};
