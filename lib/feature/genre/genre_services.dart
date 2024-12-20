import 'package:book_app_basic_arch/core/config/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/genre/genre_model.dart';
import 'package:dio/dio.dart';

class GenreServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<GenreModel>> createGenre(
      CreateGenreModel genre) async {
    try {
      return await _dioClient.post(
        '/genres',
        data: genre,
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<List<GenreModel>>> getGenres() async {
    try {
      return await _dioClient.get(
        '/genres',
        fromJsonT: (json) => (json as List)
            .map((item) => GenreModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<GenreModel>> getGenreById(String id) async {
    try {
      return await _dioClient.get(
        '/genres/$id',
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<GenreModel>> updateGenreById(
      UpdateGenreModel genre) async {
    try {
      return await _dioClient.patch(
        '/genres/${genre.id}',
        data: genre,
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<GenreModel>> deleteGenreById(String id) async {
    try {
      return await _dioClient.delete(
        '/genres/$id',
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
