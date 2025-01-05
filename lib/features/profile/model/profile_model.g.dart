// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserWithProfileModelImpl _$$UserWithProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserWithProfileModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      profilePicture: json['profilePicture'] as String,
      isVerified: json['isVerified'] as bool,
      isEmailVerified: json['isEmailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserWithProfileModelImplToJson(
        _$UserWithProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'profilePicture': instance.profilePicture,
      'isVerified': instance.isVerified,
      'isEmailVerified': instance.isEmailVerified,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'userProfile': instance.userProfile,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      bio: json['bio'] as String?,
      age: (json['age'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bio': instance.bio,
      'age': instance.age,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$UpdateUserWithProfileModelImpl _$$UpdateUserWithProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateUserWithProfileModelImpl(
      username: json['username'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UpdateUserWithProfileModelImplToJson(
        _$UpdateUserWithProfileModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'age': instance.age,
    };
