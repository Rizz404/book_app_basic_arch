import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_meta.g.dart';

@JsonSerializable()
class ApiMeta extends Equatable {
  final String version;
  final String timestamp;
  final ApiPagination? pagination;

  const ApiMeta({
    required this.version,
    required this.timestamp,
    this.pagination,
  });

  // * Harus dibuat factory dan ini penting untuk interaksi dengan json
  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);

  // ! jangan sampe salah inget
  Map<String, dynamic> toJson() => _$ApiMetaToJson(this);

  @override
  List<Object?> get props => [version, timestamp, pagination];
}
