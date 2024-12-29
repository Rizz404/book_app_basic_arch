// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistFilterModelImpl _$$WishlistFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WishlistFilterModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$WishlistFilterModelImplToJson(
        _$WishlistFilterModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
