// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorResponse _$ApiErrorResponseFromJson(Map<String, dynamic> json) =>
    ApiErrorResponse(
      status: json['status'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      meta: ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiErrorResponseToJson(ApiErrorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'meta': instance.meta,
    };
