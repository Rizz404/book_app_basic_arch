import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class UserCredentialModel with _$UserCredentialModel {
  const factory UserCredentialModel({
    required String id,
    required String username,
    required String email,
    required String role,
    required String profilePicture,
    required bool isVerified,
    required bool isEmailVerified,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String password,
    required String accessToken,
    required String refreshToken,
  }) = _UserCredentialModel;

  factory UserCredentialModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialModelFromJson(json);
}

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    required String username,
    required String email,
    required String password,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
}

@freezed
class SignInModel with _$SignInModel {
  const factory SignInModel({
    required String email,
    required String password,
  }) = _SignInModel;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
}
