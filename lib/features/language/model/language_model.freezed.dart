// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) {
  return _LanguageModel.fromJson(json);
}

/// @nodoc
mixin _$LanguageModel {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this LanguageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageModelCopyWith<LanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageModelCopyWith<$Res> {
  factory $LanguageModelCopyWith(
          LanguageModel value, $Res Function(LanguageModel) then) =
      _$LanguageModelCopyWithImpl<$Res, LanguageModel>;
  @useResult
  $Res call({String id, String code, String name});
}

/// @nodoc
class _$LanguageModelCopyWithImpl<$Res, $Val extends LanguageModel>
    implements $LanguageModelCopyWith<$Res> {
  _$LanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageModelImplCopyWith<$Res>
    implements $LanguageModelCopyWith<$Res> {
  factory _$$LanguageModelImplCopyWith(
          _$LanguageModelImpl value, $Res Function(_$LanguageModelImpl) then) =
      __$$LanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String code, String name});
}

/// @nodoc
class __$$LanguageModelImplCopyWithImpl<$Res>
    extends _$LanguageModelCopyWithImpl<$Res, _$LanguageModelImpl>
    implements _$$LanguageModelImplCopyWith<$Res> {
  __$$LanguageModelImplCopyWithImpl(
      _$LanguageModelImpl _value, $Res Function(_$LanguageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$LanguageModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageModelImpl implements _LanguageModel {
  const _$LanguageModelImpl(
      {required this.id, required this.code, required this.name});

  factory _$LanguageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'LanguageModel(id: $id, code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, name);

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      __$$LanguageModelImplCopyWithImpl<_$LanguageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageModelImplToJson(
      this,
    );
  }
}

abstract class _LanguageModel implements LanguageModel {
  const factory _LanguageModel(
      {required final String id,
      required final String code,
      required final String name}) = _$LanguageModelImpl;

  factory _LanguageModel.fromJson(Map<String, dynamic> json) =
      _$LanguageModelImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get name;

  /// Create a copy of LanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateLanguageModel _$CreateLanguageModelFromJson(Map<String, dynamic> json) {
  return _CreateLanguageModel.fromJson(json);
}

/// @nodoc
mixin _$CreateLanguageModel {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CreateLanguageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateLanguageModelCopyWith<CreateLanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateLanguageModelCopyWith<$Res> {
  factory $CreateLanguageModelCopyWith(
          CreateLanguageModel value, $Res Function(CreateLanguageModel) then) =
      _$CreateLanguageModelCopyWithImpl<$Res, CreateLanguageModel>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$CreateLanguageModelCopyWithImpl<$Res, $Val extends CreateLanguageModel>
    implements $CreateLanguageModelCopyWith<$Res> {
  _$CreateLanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateLanguageModelImplCopyWith<$Res>
    implements $CreateLanguageModelCopyWith<$Res> {
  factory _$$CreateLanguageModelImplCopyWith(_$CreateLanguageModelImpl value,
          $Res Function(_$CreateLanguageModelImpl) then) =
      __$$CreateLanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$CreateLanguageModelImplCopyWithImpl<$Res>
    extends _$CreateLanguageModelCopyWithImpl<$Res, _$CreateLanguageModelImpl>
    implements _$$CreateLanguageModelImplCopyWith<$Res> {
  __$$CreateLanguageModelImplCopyWithImpl(_$CreateLanguageModelImpl _value,
      $Res Function(_$CreateLanguageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$CreateLanguageModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateLanguageModelImpl implements _CreateLanguageModel {
  const _$CreateLanguageModelImpl({required this.code, required this.name});

  factory _$CreateLanguageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateLanguageModelImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'CreateLanguageModel(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateLanguageModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  /// Create a copy of CreateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateLanguageModelImplCopyWith<_$CreateLanguageModelImpl> get copyWith =>
      __$$CreateLanguageModelImplCopyWithImpl<_$CreateLanguageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateLanguageModelImplToJson(
      this,
    );
  }
}

abstract class _CreateLanguageModel implements CreateLanguageModel {
  const factory _CreateLanguageModel(
      {required final String code,
      required final String name}) = _$CreateLanguageModelImpl;

  factory _CreateLanguageModel.fromJson(Map<String, dynamic> json) =
      _$CreateLanguageModelImpl.fromJson;

  @override
  String get code;
  @override
  String get name;

  /// Create a copy of CreateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateLanguageModelImplCopyWith<_$CreateLanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateLanguageModel _$UpdateLanguageModelFromJson(Map<String, dynamic> json) {
  return _UpdateLanguageModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateLanguageModel {
  String get id => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this UpdateLanguageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateLanguageModelCopyWith<UpdateLanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateLanguageModelCopyWith<$Res> {
  factory $UpdateLanguageModelCopyWith(
          UpdateLanguageModel value, $Res Function(UpdateLanguageModel) then) =
      _$UpdateLanguageModelCopyWithImpl<$Res, UpdateLanguageModel>;
  @useResult
  $Res call({String id, String? code, String? name});
}

/// @nodoc
class _$UpdateLanguageModelCopyWithImpl<$Res, $Val extends UpdateLanguageModel>
    implements $UpdateLanguageModelCopyWith<$Res> {
  _$UpdateLanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateLanguageModelImplCopyWith<$Res>
    implements $UpdateLanguageModelCopyWith<$Res> {
  factory _$$UpdateLanguageModelImplCopyWith(_$UpdateLanguageModelImpl value,
          $Res Function(_$UpdateLanguageModelImpl) then) =
      __$$UpdateLanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? code, String? name});
}

/// @nodoc
class __$$UpdateLanguageModelImplCopyWithImpl<$Res>
    extends _$UpdateLanguageModelCopyWithImpl<$Res, _$UpdateLanguageModelImpl>
    implements _$$UpdateLanguageModelImplCopyWith<$Res> {
  __$$UpdateLanguageModelImplCopyWithImpl(_$UpdateLanguageModelImpl _value,
      $Res Function(_$UpdateLanguageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_$UpdateLanguageModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateLanguageModelImpl implements _UpdateLanguageModel {
  const _$UpdateLanguageModelImpl({required this.id, this.code, this.name});

  factory _$UpdateLanguageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateLanguageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? code;
  @override
  final String? name;

  @override
  String toString() {
    return 'UpdateLanguageModel(id: $id, code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLanguageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, code, name);

  /// Create a copy of UpdateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLanguageModelImplCopyWith<_$UpdateLanguageModelImpl> get copyWith =>
      __$$UpdateLanguageModelImplCopyWithImpl<_$UpdateLanguageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateLanguageModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateLanguageModel implements UpdateLanguageModel {
  const factory _UpdateLanguageModel(
      {required final String id,
      final String? code,
      final String? name}) = _$UpdateLanguageModelImpl;

  factory _UpdateLanguageModel.fromJson(Map<String, dynamic> json) =
      _$UpdateLanguageModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get code;
  @override
  String? get name;

  /// Create a copy of UpdateLanguageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateLanguageModelImplCopyWith<_$UpdateLanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
