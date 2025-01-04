import 'package:book_app_basic_arch/core/constants/api_constant.dart';
import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final UserCredentialManager credentialManager;
  bool _isRefreshing = false;
  final _pendingRequests = <RequestOptions>[];

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
      final originalRequest = err.requestOptions;

      if (!_isRefreshing) {
        _isRefreshing = true;
        _pendingRequests.add(originalRequest);

        try {
          final newCredentials = await _refreshToken();

          // Process all pending requests with new token
          for (var request in _pendingRequests) {
            final response =
                await _retryRequest(request, newCredentials.accessToken);
            if (request == originalRequest) {
              handler.resolve(response);
            }
          }
          _pendingRequests.clear();
        } catch (e) {
          await credentialManager.clearCredentials();
          for (var request in _pendingRequests) {
            if (request == originalRequest) {
              handler.reject(err);
            }
          }
          _pendingRequests.clear();
        } finally {
          _isRefreshing = false;
        }
      } else {
        _pendingRequests.add(originalRequest);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<UserCredentialModel> _refreshToken() async {
    try {
      final currentCredentials = credentialManager.credentials;
      if (currentCredentials == null) {
        throw Exception('No credentials available');
      }

      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': currentCredentials.refreshToken},
        options: Options(
          headers: ApiConstant.baseHeaders,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Assuming the response contains the full user credentials
        final newCredentials =
            UserCredentialModel.fromJson(response.data['data']);
        await credentialManager.saveCredentials(newCredentials);
        return newCredentials;
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  Future<Response> _retryRequest(
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
