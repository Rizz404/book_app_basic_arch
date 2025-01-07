import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/language/model/language_filter_model.dart';
import 'package:book_app_basic_arch/features/language/model/language_model.dart';

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
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<LanguageModel>>> getLanguages(
    LanguageFilterModel languageFilterModel,
  ) async {
    try {
      final queryParameters = {
        'page': languageFilterModel.page,
        'limit': languageFilterModel.limit,
      };

      return await _dioClient.get(
        '/languages',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List)
            .map((item) => LanguageModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<LanguageModel>> getLanguageById(String id) async {
    try {
      return await _dioClient.get(
        '/languages/$id',
        fromJsonT: (json) =>
            LanguageModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
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
    } on ApiErrorResponse catch (e) {
      throw e.message;
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
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
