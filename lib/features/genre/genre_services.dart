import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_filter_model.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';

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
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<GenreModel>>> getGenres(
    GenreFilterModel genreFilterModel,
  ) async {
    try {
      final queryParameters = {
        'page': genreFilterModel.page,
        'limit': genreFilterModel.limit,
      };

      return await _dioClient.get(
        '/genres',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final genre = GenreModel.fromJson(item as Map<String, dynamic>);
          return genre.copyWith(originalFollowStatus: genre.isFollowedGenre);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<GenreModel>> getGenreById(String id) async {
    try {
      return await _dioClient.get(
        '/genres/$id',
        fromJsonT: (json) {
          final genre = GenreModel.fromJson(json as Map<String, dynamic>);
          return genre.copyWith(originalFollowStatus: genre.isFollowedGenre);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<GenreModel>>> searchGenreByTitle({
    int page = 1,
    int limit = 10,
    required String title,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        'title': title,
      };

      return await _dioClient.get(
        '/genres/search',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final genre = GenreModel.fromJson(item as Map<String, dynamic>);
          return genre.copyWith(originalFollowStatus: genre.isFollowedGenre);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
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
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<GenreModel>> deleteGenreById(String id) async {
    try {
      return await _dioClient.delete(
        '/genres/$id',
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
