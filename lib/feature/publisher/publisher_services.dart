import 'package:book_app_basic_arch/core/config/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/publisher/model/publisher_model.dart';
import 'package:dio/dio.dart';

class PublisherServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<PublisherModel>> createPublisher(
      CreatePublisherModel publisher) async {
    try {
      return await _dioClient.post(
        '/publishers',
        data: publisher,
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<List<PublisherModel>>> getPublishers() async {
    try {
      return await _dioClient.get(
        '/publishers',
        fromJsonT: (json) => (json as List)
            .map(
                (item) => PublisherModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> getPublisherById(String id) async {
    try {
      return await _dioClient.get(
        '/publishers/$id',
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> updatePublisherById(
      UpdatePublisherModel publisher) async {
    try {
      return await _dioClient.patch(
        '/publishers/${publisher.id}',
        data: publisher,
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
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
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
