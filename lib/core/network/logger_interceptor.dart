import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('┌── Request ──────────────────────────────────────────────');
      print('│ Method: ${options.method}');
      print('│ URL: ${options.uri}');
      print('│ Headers: ${options.headers}');
      print('│ Data: ${options.data}');
      print('└─────────────────────────────────────────────────────────');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('┌── Response ─────────────────────────────────────────────');
      print('│ Status Code: ${response.statusCode}');
      print('│ Data: ${response.data}');
      print('└─────────────────────────────────────────────────────────');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('┌── Error ────────────────────────────────────────────────');
      print('│ Message: ${err.message}');
      print('│ Response: ${err.response?.data}');
      print('└─────────────────────────────────────────────────────────');
    }
    return handler.next(err);
  }
}
