import 'package:book_app_basic_arch/core/helpers/token_manager.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;
  final TokenManager _tokenManager = TokenManager();

  // static const String _baseUrl = 'http://192.168.32.16:5000/api';
  static const String _baseUrl =
      'https://straight-dareen-happiness-overload-7d6989f4.koyeb.app/api';
  static const Duration _connectTimeout = Duration(seconds: 10);
  static const Duration _receiveTimeout = Duration(seconds: 10);
  static const Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // * Flag untuk mencegah multiple refresh token requests
  bool _isRefreshing = false;

  // * Queue untuk menyimpan requests yang gagal karena token expired
  final _pendingRequests = <Function>[];

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        headers: _baseHeaders,
      ),
    )..interceptors.addAll([
        _createAuthInterceptor(),
        _createLoggerInterceptor(),
      ]);
  }

  // todo: Pindahin ke file lain
  Interceptor _createLoggerInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print('Access token stored in cache ${_tokenManager.accessToken}');
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
        final accessToken = _tokenManager.accessToken;
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
      final refreshToken = _tokenManager.refreshToken;
      if (refreshToken == null) throw Exception('No refresh token available');

      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
        options:
            Options(headers: {..._baseHeaders}), // Gunakan base headers saja
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

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        return ServerException(
          e.response?.data['message'] ?? 'Server error occurred.',
          e.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return RequestCancelledException('Request was cancelled');
      default:
        return NetworkException(e.message ?? 'Network error occurred');
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
