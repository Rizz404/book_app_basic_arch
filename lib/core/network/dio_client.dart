import 'package:book_app_basic_arch/core/constants/api_constant.dart';
import 'package:book_app_basic_arch/core/helpers/current_user_credential_manager.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_meta.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;
  final CurrentUserCredentialManager _credentialManager =
      CurrentUserCredentialManager();

  // * Flag untuk mencegah multiple refresh token requests
  bool _isRefreshing = false;

  // * Queue untuk menyimpan requests yang gagal karena token expired
  final _pendingRequests = <Function>[];

  factory DioClient() => _instance;

  DioClient._internal() {
    _initializeDio();
  }

  void _initializeDio() async {
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
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: ApiConstant.connectTimeout,
        receiveTimeout: ApiConstant.receiveTimeout,
        headers: ApiConstant.baseHeaders,
        responseType: ApiConstant.responseType,
      ),
    )..interceptors.addAll(
        [
          DioCacheInterceptor(options: customCacheOptions),
          _createAuthInterceptor(),
          _createLoggerInterceptor(),
        ],
      );
  }

  // todo: Pindahin ke file lain
  Interceptor _createLoggerInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print(
              'Access token stored in cache ${_credentialManager.accessToken}');
          print('┌── Request ──────────────────────────────────────────────');
          print('│ Method: ${options.method}');
          print('│ URL: ${options.uri}');
          // print('│ Headers: ${options.headers}');
          print('│ Data: ${options.data}');
          print('└─────────────────────────────────────────────────────────');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('┌── Response ─────────────────────────────────────────────');
          print('│ Status Code: ${response.statusCode}');
          print('│ Data: ${response.data}');
          print('└─────────────────────────────────────────────────────────');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print('┌── Error ────────────────────────────────────────────────');
          print('│ Message: ${error.message}');
          print('│ Response: ${error.response?.data}');
          print('└─────────────────────────────────────────────────────────');
        }
        return handler.next(error);
      },
    );
  }

  // todo: Pindahin ke file lain
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final accessToken = _credentialManager.accessToken;
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        final response = error.response;
        if (response?.statusCode == 401) {
          final errorMessage = response?.data['message'];

          if (errorMessage == 'Token expired' && !_isRefreshing) {
            try {
              final newAccessToken = await _refreshToken();
              // * Retry original request dengan token baru
              final retryResponse =
                  await _retryRequest(error.requestOptions, newAccessToken);
              return handler.resolve(retryResponse);
            } catch (e) {
              if (e.toString().contains('Unauthorized')) {
                // * Jika refresh token fails, clear tokens
              }
              return handler.reject(error);
            }
          } else if (errorMessage == 'Unauthorized') {
            // * Refresh token expired, clear tokens
          }
        }
        return handler.next(error);
      },
    );
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    try {
      final refreshToken = _credentialManager.refreshToken;
      if (refreshToken == null) throw Exception('No refresh token available');

      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {
          ...ApiConstant.baseHeaders,
        }), // Gunakan base headers saja
      );

      final newAccessToken = response.data['data']['accessToken'];

      // * Update access token saja

      // * Process pending requests
      for (var request in _pendingRequests) {
        await request();
      }
      _pendingRequests.clear();

      return newAccessToken;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String newAccessToken,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newAccessToken',
      },
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
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

// Custom exceptions
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, this.statusCode);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
  @override
  String toString() => message;
}
