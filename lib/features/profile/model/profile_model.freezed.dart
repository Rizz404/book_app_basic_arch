// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserWithProfileModel _$UserWithProfileModelFromJson(Map<String, dynamic> json) {
  return _UserWithProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserWithProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;

  /// Serializes this UserWithProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserWithProfileModelCopyWith<UserWithProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWithProfileModelCopyWith<$Res> {
  factory $UserWithProfileModelCopyWith(UserWithProfileModel value,
          $Res Function(UserWithProfileModel) then) =
      _$UserWithProfileModelCopyWithImpl<$Res, UserWithProfileModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String role,
      String profilePicture,
      bool isVerified,
      bool isEmailVerified,
      DateTime createdAt,
      DateTime updatedAt,
      UserProfile? userProfile});

  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class _$UserWithProfileModelCopyWithImpl<$Res,
        $Val extends UserWithProfileModel>
    implements $UserWithProfileModelCopyWith<$Res> {
  _$UserWithProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? role = null,
    Object? profilePicture = null,
    Object? isVerified = null,
    Object? isEmailVerified = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userProfile = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ) as $Val);
  }

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserWithProfileModelImplCopyWith<$Res>
    implements $UserWithProfileModelCopyWith<$Res> {
  factory _$$UserWithProfileModelImplCopyWith(_$UserWithProfileModelImpl value,
          $Res Function(_$UserWithProfileModelImpl) then) =
      __$$UserWithProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String role,
      String profilePicture,
      bool isVerified,
      bool isEmailVerified,
      DateTime createdAt,
      DateTime updatedAt,
      UserProfile? userProfile});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class __$$UserWithProfileModelImplCopyWithImpl<$Res>
    extends _$UserWithProfileModelCopyWithImpl<$Res, _$UserWithProfileModelImpl>
    implements _$$UserWithProfileModelImplCopyWith<$Res> {
  __$$UserWithProfileModelImplCopyWithImpl(_$UserWithProfileModelImpl _value,
      $Res Function(_$UserWithProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? role = null,
    Object? profilePicture = null,
    Object? isVerified = null,
    Object? isEmailVerified = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userProfile = freezed,
  }) {
    return _then(_$UserWithProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserWithProfileModelImpl implements _UserWithProfileModel {
  const _$UserWithProfileModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      required this.role,
      required this.profilePicture,
      required this.isVerified,
      required this.isEmailVerified,
      required this.createdAt,
      required this.updatedAt,
      required this.userProfile});

  factory _$UserWithProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserWithProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String role;
  @override
  final String profilePicture;
  @override
  final bool isVerified;
  @override
  final bool isEmailVerified;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final UserProfile? userProfile;

  @override
  String toString() {
    return 'UserWithProfileModel(id: $id, username: $username, email: $email, role: $role, profilePicture: $profilePicture, isVerified: $isVerified, isEmailVerified: $isEmailVerified, createdAt: $createdAt, updatedAt: $updatedAt, userProfile: $userProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWithProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      email,
      role,
      profilePicture,
      isVerified,
      isEmailVerified,
      createdAt,
      updatedAt,
      userProfile);

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWithProfileModelImplCopyWith<_$UserWithProfileModelImpl>
      get copyWith =>
          __$$UserWithProfileModelImplCopyWithImpl<_$UserWithProfileModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserWithProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UserWithProfileModel implements UserWithProfileModel {
  const factory _UserWithProfileModel(
      {required final String id,
      required final String username,
      required final String email,
      required final String role,
      required final String profilePicture,
      required final bool isVerified,
      required final bool isEmailVerified,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final UserProfile? userProfile}) = _$UserWithProfileModelImpl;

  factory _UserWithProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserWithProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get role;
  @override
  String get profilePicture;
  @override
  bool get isVerified;
  @override
  bool get isEmailVerified;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  UserProfile? get userProfile;

  /// Create a copy of UserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserWithProfileModelImplCopyWith<_$UserWithProfileModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? bio,
      int? age,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bio = freezed,
    Object? age = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? bio,
      int? age,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bio = freezed,
    Object? age = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.id,
      required this.userId,
      this.bio,
      this.age,
      required this.createdAt,
      required this.updatedAt});

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? bio;
  @override
  final int? age;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, userId: $userId, bio: $bio, age: $age, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, bio, age, createdAt, updatedAt);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final String id,
      required final String userId,
      final String? bio,
      final int? age,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get bio;
  @override
  int? get age;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateUserWithProfileModel _$UpdateUserWithProfileModelFromJson(
    Map<String, dynamic> json) {
  return _UpdateUserWithProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateUserWithProfileModel {
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;

  /// Serializes this UpdateUserWithProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateUserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateUserWithProfileModelCopyWith<UpdateUserWithProfileModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateUserWithProfileModelCopyWith<$Res> {
  factory $UpdateUserWithProfileModelCopyWith(UpdateUserWithProfileModel value,
          $Res Function(UpdateUserWithProfileModel) then) =
      _$UpdateUserWithProfileModelCopyWithImpl<$Res,
          UpdateUserWithProfileModel>;
  @useResult
  $Res call(
      {String? username, String? email, String? profilePicture, String? bio});
}

/// @nodoc
class _$UpdateUserWithProfileModelCopyWithImpl<$Res,
        $Val extends UpdateUserWithProfileModel>
    implements $UpdateUserWithProfileModelCopyWith<$Res> {
  _$UpdateUserWithProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateUserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? email = freezed,
    Object? profilePicture = freezed,
    Object? bio = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateUserWithProfileModelImplCopyWith<$Res>
    implements $UpdateUserWithProfileModelCopyWith<$Res> {
  factory _$$UpdateUserWithProfileModelImplCopyWith(
          _$UpdateUserWithProfileModelImpl value,
          $Res Function(_$UpdateUserWithProfileModelImpl) then) =
      __$$UpdateUserWithProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username, String? email, String? profilePicture, String? bio});
}

/// @nodoc
class __$$UpdateUserWithProfileModelImplCopyWithImpl<$Res>
    extends _$UpdateUserWithProfileModelCopyWithImpl<$Res,
        _$UpdateUserWithProfileModelImpl>
    implements _$$UpdateUserWithProfileModelImplCopyWith<$Res> {
  __$$UpdateUserWithProfileModelImplCopyWithImpl(
      _$UpdateUserWithProfileModelImpl _value,
      $Res Function(_$UpdateUserWithProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateUserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? email = freezed,
    Object? profilePicture = freezed,
    Object? bio = freezed,
  }) {
    return _then(_$UpdateUserWithProfileModelImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateUserWithProfileModelImpl implements _UpdateUserWithProfileModel {
  const _$UpdateUserWithProfileModelImpl(
      {this.username, this.email, this.profilePicture, this.bio});

  factory _$UpdateUserWithProfileModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdateUserWithProfileModelImplFromJson(json);

  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? profilePicture;
  @override
  final String? bio;

  @override
  String toString() {
    return 'UpdateUserWithProfileModel(username: $username, email: $email, profilePicture: $profilePicture, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserWithProfileModelImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.bio, bio) || other.bio == bio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, email, profilePicture, bio);

  /// Create a copy of UpdateUserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserWithProfileModelImplCopyWith<_$UpdateUserWithProfileModelImpl>
      get copyWith => __$$UpdateUserWithProfileModelImplCopyWithImpl<
          _$UpdateUserWithProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateUserWithProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateUserWithProfileModel
    implements UpdateUserWithProfileModel {
  const factory _UpdateUserWithProfileModel(
      {final String? username,
      final String? email,
      final String? profilePicture,
      final String? bio}) = _$UpdateUserWithProfileModelImpl;

  factory _UpdateUserWithProfileModel.fromJson(Map<String, dynamic> json) =
      _$UpdateUserWithProfileModelImpl.fromJson;

  @override
  String? get username;
  @override
  String? get email;
  @override
  String? get profilePicture;
  @override
  String? get bio;

  /// Create a copy of UpdateUserWithProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserWithProfileModelImplCopyWith<_$UpdateUserWithProfileModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
