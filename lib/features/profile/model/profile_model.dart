import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class UserWithProfileModel with _$UserWithProfileModel {
  const factory UserWithProfileModel({
    required String id,
    required String username,
    required String email,
    required String role,
    required String profilePicture,
    required bool isVerified,
    required bool isEmailVerified,
    required DateTime createdAt,
    required DateTime updatedAt,
    required UserProfile? userProfile,
  }) = _UserWithProfileModel;

  factory UserWithProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserWithProfileModelFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String userId,
    String? bio,
    int? age,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UpdateUserWithProfileModel with _$UpdateUserWithProfileModel {
  const factory UpdateUserWithProfileModel({
    String? username,
    String? email,
    String? profilePicture,
    String? bio,
    int? age,
  }) = _UpdateUserWithProfileModel;

  factory UpdateUserWithProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserWithProfileModelFromJson(json);
}
