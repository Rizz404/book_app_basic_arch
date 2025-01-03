import 'package:book_app_basic_arch/core/constants/api_constant.dart';
import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final UserCredentialManager credentialManager;
  bool isRefreshing = false;
  final List<Function> pendingRequests = [];

  AuthInterceptor({
    required this.dio,
    required this.credentialManager,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = credentialManager.accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final errorMessage = err.response?.data['message'];

      if (errorMessage == 'Token expired' && !isRefreshing) {
        try {
          final newAccessToken = await _refreshToken();

          // Update request options dengan token baru
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          // Retry request dengan options yang sudah diupdate
          final retryResponse =
              await _retryRequest(err.requestOptions, newAccessToken);
          return handler.resolve(retryResponse);
        } catch (e) {
          if (e.toString().contains('Unauthorized')) {
            await credentialManager.clearTokens();
          }
          return handler.reject(err);
        }
      } else if (errorMessage == 'Unauthorized') {
        await credentialManager.clearTokens();
      }
    }
    return handler.next(err);
  }

  Future<String> _refreshToken() async {
    isRefreshing = true;
    try {
      final refreshToken = credentialManager.refreshToken;
      if (refreshToken == null) throw Exception('No refresh token available');

      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
        options: Options(headers: ApiConstant.baseHeaders),
      );

      final newAccessToken = response.data['data']['accessToken'];

      // Update token di credential manager
      await credentialManager.saveCredentials(accessToken: newAccessToken);

      // Update default headers di Dio instance
      dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

      // Process pending requests dengan token baru
      for (var request in pendingRequests) {
        await request();
      }
      pendingRequests.clear();

      return newAccessToken;
    } finally {
      isRefreshing = false;
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
}
