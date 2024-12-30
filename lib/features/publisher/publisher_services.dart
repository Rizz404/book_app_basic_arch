import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';

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
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<PublisherModel>>> getPublishers({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
      };

      return await _dioClient.get(
        '/publishers',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List)
            .map(
                (item) => PublisherModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<PublisherModel>> getPublisherById(String id) async {
    try {
      return await _dioClient.get(
        '/publishers/$id',
        fromJsonT: (json) =>
            PublisherModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
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
