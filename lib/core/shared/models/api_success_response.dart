import 'package:book_app_basic_arch/core/shared/models/api_meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_success_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiSuccessResponse<T> extends Equatable {
  final bool status;
  final int statusCode;
  final String message;
  final T? data;
  final ApiMeta meta;

  const ApiSuccessResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ApiSuccessResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiSuccessResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) =>
      _$ApiSuccessResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [status, statusCode, message, data, meta];

  // * Metode copyWith untuk mendukung perubahan properti secara parsial**
  ApiSuccessResponse<K> copyWith<K>({
    bool? status,
    int? statusCode,
    String? message,
    K? data,
    ApiMeta? meta,
  }) {
    return ApiSuccessResponse<K>(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data as K?,
      meta: meta ?? this.meta,
    );
  }
}
