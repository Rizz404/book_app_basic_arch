import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_pagination.g.dart';

@JsonSerializable()
class ApiPagination extends Equatable {
  final int currentPage;
  final int itemsPerPage;
  final int totalItems;
  final int totalPages;
  final int? previousPage;
  final int? nextPage;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const ApiPagination({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalItems,
    required this.totalPages,
    this.previousPage,
    this.nextPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  // * Harus dibuat factory dan ini penting untuk interaksi dengan json
  factory ApiPagination.fromJson(Map<String, dynamic> json) =>
      _$ApiPaginationFromJson(json);

  // ! jangan sampe salah inget
  Map<String, dynamic> toJson() => _$ApiPaginationToJson(this);

  // * Pake equatable harus pake ini
  @override
  List<Object?> get props => [
        currentPage,
        itemsPerPage,
        totalItems,
        totalPages,
        previousPage,
        nextPage,
        hasPreviousPage,
        hasNextPage
      ];
}
