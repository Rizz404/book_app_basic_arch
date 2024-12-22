import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  // Konstanta untuk konfigurasi
  // static const String _baseUrl = 'http://192.168.32.16:5000/api';
  static const String _baseUrl =
      'https://straight-dareen-happiness-overload-7d6989f4.koyeb.app/api';
  static const Duration _connectTimeout = Duration(seconds: 10);
  static const Duration _receiveTimeout = Duration(seconds: 10);
  static const Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

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
        _createLoggerInterceptor(),
      ]);
  }

  Interceptor _createLoggerInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print('┌── Request ──────────────────────────────────────────────');
          print('│ Method: ${options.method}');
          print('│ URL: ${options.uri}');
          print('│ Headers: ${options.headers}');
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

  // Generic request methods
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
