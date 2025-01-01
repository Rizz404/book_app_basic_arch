import 'package:book_app_basic_arch/core/constants/api_constant.dart';
import 'package:book_app_basic_arch/core/helpers/current_user_credential_manager.dart';
import 'package:book_app_basic_arch/core/network/auth_interceptor.dart';
import 'package:book_app_basic_arch/core/network/logger_interceptor.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_meta.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;
  final CurrentUserCredentialManager _credentialManager =
      CurrentUserCredentialManager();

  factory DioClient() => _instance;

  DioClient._internal() {
    // Inisialisasi langsung, bukan async
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: ApiConstant.connectTimeout,
        receiveTimeout: ApiConstant.receiveTimeout,
        headers: ApiConstant.baseHeaders,
        responseType: ApiConstant.responseType,
      ),
    );

    // Setup cache dan interceptor secara async
    _setupCache();
  }

  Future<void> _setupCache() async {
    var cacheDir = await getTemporaryDirectory();
    var cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "dio_cache",
    );

    var customCacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(minutes: 1),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) => request.uri.toString(),
      allowPostMethod: false,
    );

    dio.interceptors.addAll([
      DioCacheInterceptor(options: customCacheOptions),
      AuthInterceptor(dio: dio, credentialManager: _credentialManager),
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
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiSuccessResponse<T>.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      // todo: Error handle benerin biar bisa throw
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
      // If we have response data, try to parse it as ApiErrorResponse
      try {
        final errorResponse = ApiErrorResponse.fromJson(e.response?.data);
        return errorResponse;
      } catch (_) {
        // If parsing fails, fall through to default error handling
      }
    }

    // Default error handling for other types of errors
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
