// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LanguageFilterModel _$LanguageFilterModelFromJson(Map<String, dynamic> json) {
  return _LanguageFilterModel.fromJson(json);
}

/// @nodoc
mixin _$LanguageFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this LanguageFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguageFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageFilterModelCopyWith<LanguageFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageFilterModelCopyWith<$Res> {
  factory $LanguageFilterModelCopyWith(
          LanguageFilterModel value, $Res Function(LanguageFilterModel) then) =
      _$LanguageFilterModelCopyWithImpl<$Res, LanguageFilterModel>;
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class _$LanguageFilterModelCopyWithImpl<$Res, $Val extends LanguageFilterModel>
    implements $LanguageFilterModelCopyWith<$Res> {
  _$LanguageFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguageFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageFilterModelImplCopyWith<$Res>
    implements $LanguageFilterModelCopyWith<$Res> {
  factory _$$LanguageFilterModelImplCopyWith(_$LanguageFilterModelImpl value,
          $Res Function(_$LanguageFilterModelImpl) then) =
      __$$LanguageFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class __$$LanguageFilterModelImplCopyWithImpl<$Res>
    extends _$LanguageFilterModelCopyWithImpl<$Res, _$LanguageFilterModelImpl>
    implements _$$LanguageFilterModelImplCopyWith<$Res> {
  __$$LanguageFilterModelImplCopyWithImpl(_$LanguageFilterModelImpl _value,
      $Res Function(_$LanguageFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LanguageFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_$LanguageFilterModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageFilterModelImpl implements _LanguageFilterModel {
  const _$LanguageFilterModelImpl({this.page = 1, this.limit = 10});

  factory _$LanguageFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'LanguageFilterModel(page: $page, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit);

  /// Create a copy of LanguageFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageFilterModelImplCopyWith<_$LanguageFilterModelImpl> get copyWith =>
      __$$LanguageFilterModelImplCopyWithImpl<_$LanguageFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageFilterModelImplToJson(
      this,
    );
  }
}

abstract class _LanguageFilterModel implements LanguageFilterModel {
  const factory _LanguageFilterModel({final int page, final int limit}) =
      _$LanguageFilterModelImpl;

  factory _LanguageFilterModel.fromJson(Map<String, dynamic> json) =
      _$LanguageFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;

  /// Create a copy of LanguageFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageFilterModelImplCopyWith<_$LanguageFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
