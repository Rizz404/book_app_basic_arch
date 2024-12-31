// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCredentialModelImpl _$$UserCredentialModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserCredentialModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      profilePicture: json['profilePicture'] as String,
      isVerified: json['isVerified'] as bool,
      isEmailVerified: json['isEmailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      password: json['password'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$UserCredentialModelImplToJson(
        _$UserCredentialModelImpl instance) =>
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
      'password': instance.password,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$SignUpModelImpl _$$SignUpModelImplFromJson(Map<String, dynamic> json) =>
    _$SignUpModelImpl(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$SignUpModelImplToJson(_$SignUpModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };

_$SignInModelImpl _$$SignInModelImplFromJson(Map<String, dynamic> json) =>
    _$SignInModelImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$SignInModelImplToJson(_$SignInModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
