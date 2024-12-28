import 'package:dio/dio.dart';

class ApiConstant {
  static const String baseUrl =
      'https://straight-dareen-happiness-overload-7d6989f4.koyeb.app/api';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Map<String, String> baseHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static const ResponseType responseType = ResponseType.json;
}
