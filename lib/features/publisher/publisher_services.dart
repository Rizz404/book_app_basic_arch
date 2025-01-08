import 'dart:io';

import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_filter_model.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:dio/dio.dart';

class PublisherServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<PublisherModel>> createPublisher(
    CreatePublisherModel publisher,
    File? picture,
  ) async {
    try {
      final formData = FormData.fromMap({
        'name': publisher.name,
        'description': publisher.description,
        'email': publisher.email,
        'website': publisher.website,

        // * Jika ada file baru, kirim sebagai MultipartFile
        if (picture != null)
          'picture': await MultipartFile.fromFile(
            picture.path,
            filename: picture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (picture == null && publisher.picture != null)
          'picture': publisher.picture,
      });

      return await _dioClient.post(
        '/publishers',
        data: formData,
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<PublisherModel>>> getPublishers(
      PublisherFilterModel publisherFilterModel) async {
    try {
      final queryParameters = {
        'page': publisherFilterModel.page,
        'limit': publisherFilterModel.limit,
      };

      return await _dioClient.get(
        '/publishers',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final publisher =
              PublisherModel.fromJson(item as Map<String, dynamic>);
          return publisher.copyWith(
              originalFollowStatus: publisher.isFollowedPublisher);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> getPublisherById(String id) async {
    try {
      return await _dioClient.get(
        '/publishers/$id',
        fromJsonT: (json) {
          final publisher =
              PublisherModel.fromJson(json as Map<String, dynamic>);
          return publisher.copyWith(
              originalFollowStatus: publisher.isFollowedPublisher);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<PublisherModel>>> searchPublishersByName({
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
        '/publishers/search',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final publisher =
              PublisherModel.fromJson(item as Map<String, dynamic>);
          return publisher.copyWith(
              originalFollowStatus: publisher.isFollowedPublisher);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> updatePublisherById(
    UpdatePublisherModel publisher,
    File? picture,
  ) async {
    try {
      final formData = FormData.fromMap({
        if (publisher.name != null) 'name': publisher.name,
        if (publisher.description != null) 'description': publisher.description,
        if (publisher.email != null) 'email': publisher.email,
        if (publisher.website != null) 'website': publisher.website,

        // * Jika ada file baru, kirim sebagai MultipartFile
        if (picture != null)
          'picture': await MultipartFile.fromFile(
            picture.path,
            filename: picture.path.split('/').last,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (picture == null && publisher.picture != null)
          'picture': publisher.picture,
      });

      return await _dioClient.patch(
        '/publishers/${publisher.id}',
        data: formData,
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> deletePublisherById(
      String id) async {
    try {
      return await _dioClient.delete(
        '/publishers/$id',
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
