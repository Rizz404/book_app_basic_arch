import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/profile/model/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<UserWithProfileModel>> getUserProfile() async {
    try {
      return await _dioClient.get(
        '/users/profile',
        fromJsonT: (json) =>
            UserWithProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      final errorResponse = ApiErrorResponse.fromJson(e.response?.data);
      throw errorResponse.message;
    }
  }

  Future<ApiSuccessResponse<UserWithProfileModel>> updateUserProfile(
      UpdateUserWithProfileModel profile) async {
    try {
      return await _dioClient.patch(
        '/users/profile',
        data: profile,
        fromJsonT: (json) =>
            UserWithProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      final errorResponse = ApiErrorResponse.fromJson(e.response?.data);
      throw errorResponse.message;
    }
  }
}
