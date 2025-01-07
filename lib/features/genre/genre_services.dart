import 'dart:io';

import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_filter_model.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GenreServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<GenreModel>> createGenre(
    CreateGenreModel genre,
    File? picture,
  ) async {
    try {
      final formData = FormData.fromMap({
        'name': genre.name,
        'description': genre.description,
        // * Jika ada file baru, kirim sebagai MultipartFile
        if (picture != null)
          'picture': await MultipartFile.fromFile(
            picture.path,
            filename: picture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (picture == null && genre.picture != null) 'picture': genre.picture,
      });

      debugPrint(formData.toString());

      return await _dioClient.post(
        '/genres',
        data: formData,
        fromJsonT: (json) => GenreModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<GenreModel>>> getGenres(
    GenreFilterModel genreFilterModel, {
    bool forceRefresh = false,
  }) async {
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

  Future<ApiSuccessResponse<List<GenreModel>>> searchGenresByName({
    int page = 1,
    int limit = 10,
    required String name,
    bool forceRefresh = false,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        'name': name,
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
    UpdateGenreModel genre,
    File? picture,
  ) async {
    try {
      final formData = FormData.fromMap({
        if (genre.name != null) 'name': genre.name,
        if (genre.description != null) 'description': genre.description,
        // * Jika ada file baru, kirim sebagai MultipartFile
        if (picture != null)
          'picture': await MultipartFile.fromFile(
            picture.path,
            filename: picture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (picture == null && genre.picture != null) 'picture': genre.picture,
      });

      debugPrint(formData.toString());

      return await _dioClient.patch(
        '/genres/${genre.id}',
        data: formData,
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
