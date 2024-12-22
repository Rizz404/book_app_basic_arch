import 'package:book_app_basic_arch/core/config/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/auth/model/auth_model.dart';
import 'package:dio/dio.dart';

class AuthServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<String>> signUp(SignUpModel payload) async {
    try {
      return await _dioClient.post('/auth/sign-up',
          data: payload, fromJsonT: (Object? json) => (json.toString()));
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<UserCredentialModel>> signIn(
      SignInModel payload) async {
    try {
      return await _dioClient.post('/auth/sign-in',
          data: payload,
          fromJsonT: (json) =>
              UserCredentialModel.fromJson(json as Map<String, dynamic>));
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
