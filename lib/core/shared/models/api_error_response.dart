import 'package:book_app_basic_arch/core/shared/models/api_meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable()
class ApiErrorResponse extends Equatable {
  final bool status;
  final int statusCode;
  final String message;
  final ApiMeta meta;

  const ApiErrorResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.meta,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);

  @override
  List<Object?> get props => [status, statusCode, message, meta];
}
