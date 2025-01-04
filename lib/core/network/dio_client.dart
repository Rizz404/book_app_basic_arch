import 'package:book_app_basic_arch/core/constants/api_constant.dart';
import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:book_app_basic_arch/core/network/auth_interceptor.dart';
import 'package:book_app_basic_arch/core/network/logger_interceptor.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_meta.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    // * Inisialisasi langsung, bukan async
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: ApiConstant.connectTimeout,
        receiveTimeout: ApiConstant.receiveTimeout,
        headers: ApiConstant.baseHeaders,
        responseType: ApiConstant.responseType,
      ),
    );

    // * Setup cache dan interceptor secara async
    _setupInterceptors();
  }

  Future<void> _setupInterceptors() async {
    final authInterceptor = AuthInterceptor(
      dio: dio,
      credentialManager: UserCredentialManager(),
    );

    dio.interceptors.addAll([
      authInterceptor,
      LoggerInterceptor(),
    ]);
  }

  // * Generic request methods
  Future<ApiSuccessResponse<T>> get<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool forceRefresh = false, // * Buat force refresh
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiSuccessResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      // * todo: Error handle benerin biar bisa throw
      throw _handleDioException(e);
    }
  }

  Future<ApiSuccessResponse<T>> post<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiSuccessResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<ApiSuccessResponse<T>> patch<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiSuccessResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<ApiSuccessResponse<T>> delete<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiSuccessResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  ApiErrorResponse _handleDioException(DioException e) {
    if (e.response?.data != null) {
      // * If we have response data, try to parse it as ApiErrorResponse
      try {
        final errorResponse = ApiErrorResponse.fromJson(e.response?.data);
        return errorResponse;
      } catch (_) {
        // * If parsing fails, fall through to default error handling
      }
    }

    // * Default error handling for other types of errors
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiErrorResponse(
          status: false,
          statusCode: 408,
          message: 'Connection timeout. Please try again.',
          meta: ApiMeta(
            timestamp: DateTime.now().toIso8601String(),
            version: '1.0.0',
          ),
        );
      case DioExceptionType.badResponse:
        return ApiErrorResponse(
          status: false,
          statusCode: e.response?.statusCode ?? 500,
          message: 'Server error occurred.',
          meta: ApiMeta(
            timestamp: DateTime.now().toIso8601String(),
            version: '1.0.0',
          ),
        );
      case DioExceptionType.cancel:
        return ApiErrorResponse(
          status: false,
          statusCode: 499,
          message: 'Request was cancelled',
          meta: ApiMeta(
            timestamp: DateTime.now().toIso8601String(),
            version: '1.0.0',
          ),
        );
      default:
        return ApiErrorResponse(
          status: false,
          statusCode: 500,
          message: e.message ?? 'Network error occurred',
          meta: ApiMeta(
            timestamp: DateTime.now().toIso8601String(),
            version: '1.0.0',
          ),
        );
    }
  }
}
