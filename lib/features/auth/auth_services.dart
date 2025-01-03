import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';

class AuthServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<String>> signUp(SignUpModel payload) async {
    try {
      return await _dioClient.post('/auth/sign-up',
          data: payload, fromJsonT: (Object? json) => (json.toString()));
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<UserCredentialModel>> signIn(
      SignInModel payload) async {
    try {
      return await _dioClient.post('/auth/sign-in',
          data: payload,
          fromJsonT: (json) =>
              UserCredentialModel.fromJson(json as Map<String, dynamic>));
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
