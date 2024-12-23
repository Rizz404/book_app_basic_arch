import 'package:book_app_basic_arch/core/config/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/language/model/language_model.dart';
import 'package:dio/dio.dart';

class LanguageServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<LanguageModel>> createLanguage(
      CreateLanguageModel language) async {
    try {
      return await _dioClient.post(
        '/languages',
        data: language,
        fromJsonT: (json) =>
            LanguageModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<List<LanguageModel>>> getLanguages() async {
    try {
      return await _dioClient.get(
        '/languages',
        fromJsonT: (json) => (json as List)
            .map((item) => LanguageModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<LanguageModel>> getLanguageById(String id) async {
    try {
      return await _dioClient.get(
        '/languages/$id',
        fromJsonT: (json) =>
            LanguageModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<LanguageModel>> updateLanguageById(
      UpdateLanguageModel language) async {
    try {
      return await _dioClient.patch(
        '/languages/${language.id}',
        data: language,
        fromJsonT: (json) =>
            LanguageModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<LanguageModel>> deleteLanguageById(
      String id) async {
    try {
      return await _dioClient.delete(
        '/languages/$id',
        fromJsonT: (json) =>
            LanguageModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
