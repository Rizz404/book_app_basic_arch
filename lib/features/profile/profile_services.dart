import 'dart:io';

import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<UserWithProfileModel>> getUserProfile() async {
    try {
      return await _dioClient.get(
        '/users/profile',
        fromJsonT: (json) =>
            UserWithProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<UserWithProfileModel>> updateUserProfile(
    UpdateUserWithProfileModel profile, {
    File? profilePictureFile,
  }) async {
    try {
      // * Buat FormData
      final formData = FormData.fromMap({
        if (profile.username != null) 'username': profile.username,
        if (profile.email != null) 'email': profile.email,
        if (profile.bio != null) 'bio': profile.bio,
        if (profile.age != null) 'age': profile.age,
        // * Jika ada file baru, kirim sebagai MultipartFile
        if (profilePictureFile != null)
          'profilePicture': await MultipartFile.fromFile(
            profilePictureFile.path,
          ),
        // * Jika tidak ada file tapi ada URL, kirim URL-nya
        if (profilePictureFile == null && profile.profilePicture != null)
          'profilePicture': profile.profilePicture,
      });

      debugPrint(formData.toString());

      return await _dioClient.patch(
        '/users/profile',
        data: formData,
        fromJsonT: (json) =>
            UserWithProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
