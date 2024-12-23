// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publisher_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublisherModel _$PublisherModelFromJson(Map<String, dynamic> json) {
  return _PublisherModel.fromJson(json);
}

/// @nodoc
mixin _$PublisherModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get website => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PublisherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublisherModelCopyWith<PublisherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublisherModelCopyWith<$Res> {
  factory $PublisherModelCopyWith(
          PublisherModel value, $Res Function(PublisherModel) then) =
      _$PublisherModelCopyWithImpl<$Res, PublisherModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String description,
      List<String> website,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PublisherModelCopyWithImpl<$Res, $Val extends PublisherModel>
    implements $PublisherModelCopyWith<$Res> {
  _$PublisherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? description = null,
    Object? website = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$PublisherModelImplCopyWith<$Res>
    implements $PublisherModelCopyWith<$Res> {
  factory _$$PublisherModelImplCopyWith(_$PublisherModelImpl value,
          $Res Function(_$PublisherModelImpl) then) =
      __$$PublisherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String description,
      List<String> website,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$PublisherModelImplCopyWithImpl<$Res>
    extends _$PublisherModelCopyWithImpl<$Res, _$PublisherModelImpl>
    implements _$$PublisherModelImplCopyWith<$Res> {
  __$$PublisherModelImplCopyWithImpl(
      _$PublisherModelImpl _value, $Res Function(_$PublisherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? description = null,
    Object? website = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PublisherModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value._website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$PublisherModelImpl implements _PublisherModel {
  const _$PublisherModelImpl(
      {required this.id,
      required this.name,
      required this.email,
      required this.description,
      required final List<String> website,
      required this.createdAt,
      required this.updatedAt})
      : _website = website;

  factory _$PublisherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublisherModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String description;
  final List<String> _website;
  @override
  List<String> get website {
    if (_website is EqualUnmodifiableListView) return _website;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_website);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PublisherModel(id: $id, name: $name, email: $email, description: $description, website: $website, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublisherModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._website, _website) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, description,
      const DeepCollectionEquality().hash(_website), createdAt, updatedAt);

  /// Create a copy of PublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublisherModelImplCopyWith<_$PublisherModelImpl> get copyWith =>
      __$$PublisherModelImplCopyWithImpl<_$PublisherModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublisherModelImplToJson(
      this,
    );
  }
}

abstract class _PublisherModel implements PublisherModel {
  const factory _PublisherModel(
      {required final String id,
      required final String name,
      required final String email,
      required final String description,
      required final List<String> website,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PublisherModelImpl;

  factory _PublisherModel.fromJson(Map<String, dynamic> json) =
      _$PublisherModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get description;
  @override
  List<String> get website;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublisherModelImplCopyWith<_$PublisherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatePublisherModel _$CreatePublisherModelFromJson(Map<String, dynamic> json) {
  return _CreatePublisherModel.fromJson(json);
}

/// @nodoc
mixin _$CreatePublisherModel {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get website => throw _privateConstructorUsedError;

  /// Serializes this CreatePublisherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePublisherModelCopyWith<CreatePublisherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePublisherModelCopyWith<$Res> {
  factory $CreatePublisherModelCopyWith(CreatePublisherModel value,
          $Res Function(CreatePublisherModel) then) =
      _$CreatePublisherModelCopyWithImpl<$Res, CreatePublisherModel>;
  @useResult
  $Res call(
      {String name, String email, String description, List<String> website});
}

/// @nodoc
class _$CreatePublisherModelCopyWithImpl<$Res,
        $Val extends CreatePublisherModel>
    implements $CreatePublisherModelCopyWith<$Res> {
  _$CreatePublisherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? description = null,
    Object? website = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePublisherModelImplCopyWith<$Res>
    implements $CreatePublisherModelCopyWith<$Res> {
  factory _$$CreatePublisherModelImplCopyWith(_$CreatePublisherModelImpl value,
          $Res Function(_$CreatePublisherModelImpl) then) =
      __$$CreatePublisherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String email, String description, List<String> website});
}

/// @nodoc
class __$$CreatePublisherModelImplCopyWithImpl<$Res>
    extends _$CreatePublisherModelCopyWithImpl<$Res, _$CreatePublisherModelImpl>
    implements _$$CreatePublisherModelImplCopyWith<$Res> {
  __$$CreatePublisherModelImplCopyWithImpl(_$CreatePublisherModelImpl _value,
      $Res Function(_$CreatePublisherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? description = null,
    Object? website = null,
  }) {
    return _then(_$CreatePublisherModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value._website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePublisherModelImpl implements _CreatePublisherModel {
  const _$CreatePublisherModelImpl(
      {required this.name,
      required this.email,
      required this.description,
      required final List<String> website})
      : _website = website;

  factory _$CreatePublisherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePublisherModelImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String description;
  final List<String> _website;
  @override
  List<String> get website {
    if (_website is EqualUnmodifiableListView) return _website;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_website);
  }

  @override
  String toString() {
    return 'CreatePublisherModel(name: $name, email: $email, description: $description, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePublisherModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._website, _website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, description,
      const DeepCollectionEquality().hash(_website));

  /// Create a copy of CreatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePublisherModelImplCopyWith<_$CreatePublisherModelImpl>
      get copyWith =>
          __$$CreatePublisherModelImplCopyWithImpl<_$CreatePublisherModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePublisherModelImplToJson(
      this,
    );
  }
}

abstract class _CreatePublisherModel implements CreatePublisherModel {
  const factory _CreatePublisherModel(
      {required final String name,
      required final String email,
      required final String description,
      required final List<String> website}) = _$CreatePublisherModelImpl;

  factory _CreatePublisherModel.fromJson(Map<String, dynamic> json) =
      _$CreatePublisherModelImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get description;
  @override
  List<String> get website;

  /// Create a copy of CreatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePublisherModelImplCopyWith<_$CreatePublisherModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdatePublisherModel _$UpdatePublisherModelFromJson(Map<String, dynamic> json) {
  return _UpdatePublisherModel.fromJson(json);
}

/// @nodoc
mixin _$UpdatePublisherModel {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get website => throw _privateConstructorUsedError;

  /// Serializes this UpdatePublisherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePublisherModelCopyWith<UpdatePublisherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePublisherModelCopyWith<$Res> {
  factory $UpdatePublisherModelCopyWith(UpdatePublisherModel value,
          $Res Function(UpdatePublisherModel) then) =
      _$UpdatePublisherModelCopyWithImpl<$Res, UpdatePublisherModel>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? email,
      String? description,
      List<String>? website});
}

/// @nodoc
class _$UpdatePublisherModelCopyWithImpl<$Res,
        $Val extends UpdatePublisherModel>
    implements $UpdatePublisherModelCopyWith<$Res> {
  _$UpdatePublisherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? description = freezed,
    Object? website = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePublisherModelImplCopyWith<$Res>
    implements $UpdatePublisherModelCopyWith<$Res> {
  factory _$$UpdatePublisherModelImplCopyWith(_$UpdatePublisherModelImpl value,
          $Res Function(_$UpdatePublisherModelImpl) then) =
      __$$UpdatePublisherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? email,
      String? description,
      List<String>? website});
}

/// @nodoc
class __$$UpdatePublisherModelImplCopyWithImpl<$Res>
    extends _$UpdatePublisherModelCopyWithImpl<$Res, _$UpdatePublisherModelImpl>
    implements _$$UpdatePublisherModelImplCopyWith<$Res> {
  __$$UpdatePublisherModelImplCopyWithImpl(_$UpdatePublisherModelImpl _value,
      $Res Function(_$UpdatePublisherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? description = freezed,
    Object? website = freezed,
  }) {
    return _then(_$UpdatePublisherModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value._website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePublisherModelImpl implements _UpdatePublisherModel {
  const _$UpdatePublisherModelImpl(
      {required this.id,
      this.name,
      this.email,
      this.description,
      final List<String>? website})
      : _website = website;

  factory _$UpdatePublisherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePublisherModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? description;
  final List<String>? _website;
  @override
  List<String>? get website {
    final value = _website;
    if (value == null) return null;
    if (_website is EqualUnmodifiableListView) return _website;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UpdatePublisherModel(id: $id, name: $name, email: $email, description: $description, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePublisherModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._website, _website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, description,
      const DeepCollectionEquality().hash(_website));

  /// Create a copy of UpdatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePublisherModelImplCopyWith<_$UpdatePublisherModelImpl>
      get copyWith =>
          __$$UpdatePublisherModelImplCopyWithImpl<_$UpdatePublisherModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePublisherModelImplToJson(
      this,
    );
  }
}

abstract class _UpdatePublisherModel implements UpdatePublisherModel {
  const factory _UpdatePublisherModel(
      {required final String id,
      final String? name,
      final String? email,
      final String? description,
      final List<String>? website}) = _$UpdatePublisherModelImpl;

  factory _UpdatePublisherModel.fromJson(Map<String, dynamic> json) =
      _$UpdatePublisherModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get description;
  @override
  List<String>? get website;

  /// Create a copy of UpdatePublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePublisherModelImplCopyWith<_$UpdatePublisherModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
