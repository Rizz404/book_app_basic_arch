// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPagination _$ApiPaginationFromJson(Map<String, dynamic> json) =>
    ApiPagination(
      currentPage: (json['currentPage'] as num).toInt(),
      itemsPerPage: (json['itemsPerPage'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      previousPage: (json['previousPage'] as num?)?.toInt(),
      nextPage: (json['nextPage'] as num?)?.toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$ApiPaginationToJson(ApiPagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'itemsPerPage': instance.itemsPerPage,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'previousPage': instance.previousPage,
      'nextPage': instance.nextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
