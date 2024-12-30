import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/author/model/author_filter_model.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';

class AuthorServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<AuthorModel>> createAuthor(
      CreateAuthorModel author) async {
    try {
      return await _dioClient.post(
        '/authors',
        data: author,
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<AuthorModel>>> getAuthors(
    AuthorFilterModel authorFilterModel,
  ) async {
    try {
      final queryParameters = {
        'page': authorFilterModel.page,
        'limit': authorFilterModel.limit,
        if (authorFilterModel.birthDateRange != null)
          'birthDateRange': authorFilterModel.birthDateRange,
        if (authorFilterModel.deathDateRange != null)
          'deathDateRange': authorFilterModel.deathDateRange,
      };

      return await _dioClient.get(
        '/authors',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List)
            .map((item) => AuthorModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> getAuthorById(String id) async {
    try {
      return await _dioClient.get(
        '/authors/$id',
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> updateAuthorById(
      UpdateAuthorModel author) async {
    try {
      return await _dioClient.patch(
        '/authors/${author.id}',
        data: author,
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> deleteAuthorById(String id) async {
    try {
      return await _dioClient.delete(
        '/authors/$id',
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
