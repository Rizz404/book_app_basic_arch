// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublisherFilterModelImpl _$$PublisherFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PublisherFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$PublisherFilterModelImplToJson(
        _$PublisherFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
