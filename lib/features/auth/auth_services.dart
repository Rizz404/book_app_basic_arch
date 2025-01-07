import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';

class AuthServices {
  final DioClient _dioClient = DioClient();
  final _credentialManager = UserCredentialManager();

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
      final response = await _dioClient.post<UserCredentialModel>(
        '/auth/sign-in',
        data: payload.toJson(),
        fromJsonT: (json) =>
            UserCredentialModel.fromJson(json as Map<String, dynamic>),
      );

      // Simpan credentials di service layer
      await _credentialManager.saveCredentials(response.data!);

      return response;
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<void> signOut() async {
    await _credentialManager.clearCredentials();
  }

  // * Tambahkan method untuk mengambil credentials yang tersimpan
  Future<UserCredentialModel?> getCurrentCredentials() async {
    return _credentialManager.credentials;
  }
}
