import 'dart:io';

import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/author/model/author_filter_model.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:dio/dio.dart';

class AuthorServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<AuthorModel>> createAuthor(
    CreateAuthorModel author,
    File? profilePicture,
  ) async {
    try {
      final formData = FormData.fromMap({
        'name': author.name,
        'biography': author.biography,
        'birthDate': author.birthDate,
        'deathDate': author.deathDate,
        // * Jika ada file baru, kirim sebagai MultipartFile
        if (profilePicture != null)
          'profilePicture': await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (profilePicture == null && author.profilePicture != null)
          'profilePicture': author.profilePicture,
      });

      return await _dioClient.post(
        '/authors',
        data: formData,
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
        fromJsonT: (json) => (json as List).map((item) {
          final author = AuthorModel.fromJson(item as Map<String, dynamic>);
          return author.copyWith(originalFollowStatus: author.isFollowedAuthor);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> getAuthorById(String id) async {
    try {
      return await _dioClient.get(
        '/authors/$id',
        fromJsonT: (json) {
          final author = AuthorModel.fromJson(json as Map<String, dynamic>);
          return author.copyWith(originalFollowStatus: author.isFollowedAuthor);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<AuthorModel>>> searchAuthorsByName({
    int page = 1,
    int limit = 10,
    required String name,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        'name': name,
      };

      return await _dioClient.get(
        '/authors/search',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final author = AuthorModel.fromJson(item as Map<String, dynamic>);
          return author.copyWith(originalFollowStatus: author.isFollowedAuthor);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<AuthorModel>> updateAuthorById(
      UpdateAuthorModel author, File? profilePicture) async {
    try {
      final formData = FormData.fromMap({
        if (author.name != null) 'name': author.name,
        if (author.biography != null) 'biography': author.biography,
        if (author.birthDate != null) 'birthDate': author.birthDate,
        if (author.deathDate != null) 'deathDate': author.deathDate,
        // * Jika ada file baru, kirim sebagai MultipartFile
        if (profilePicture != null)
          'profilePicture': await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (profilePicture == null && author.profilePicture != null)
          'profilePicture': author.profilePicture,
      });

      return await _dioClient.patch(
        '/authors/${author.id}',
        data: formData,
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

  // * Gabungin aja biarpun routesnya beda, nanti backend kapan kapan benerin
  Future<ApiSuccessResponse<void>> followAuthorById(String id) async {
    try {
      return await _dioClient.post(
        '/author-follows/$id',
        fromJsonT: (json) {},
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<AuthorModel>>> getAuthorsFollowed(
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
        '/author-follows',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final author = AuthorModel.fromJson(item as Map<String, dynamic>);
          return author.copyWith(originalFollowStatus: author.isFollowedAuthor);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<void>> unfollowAuthorById(String id) async {
    try {
      return await _dioClient.delete(
        '/author-follows/$id',
        fromJsonT: (json) {},
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
