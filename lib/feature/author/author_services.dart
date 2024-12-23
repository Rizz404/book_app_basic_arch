import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/author/model/author_model.dart';
import 'package:dio/dio.dart';

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
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<List<AuthorModel>>> getAuthors() async {
    try {
      return await _dioClient.get(
        '/authors',
        fromJsonT: (json) => (json as List)
            .map((item) => AuthorModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> getAuthorById(String id) async {
    try {
      return await _dioClient.get(
        '/authors/$id',
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
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
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> deleteAuthorById(String id) async {
    try {
      return await _dioClient.delete(
        '/authors/$id',
        fromJsonT: (json) => AuthorModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
