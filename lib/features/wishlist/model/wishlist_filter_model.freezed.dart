// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WishlistFilterModel _$WishlistFilterModelFromJson(Map<String, dynamic> json) {
  return _WishlistFilterModel.fromJson(json);
}

/// @nodoc
mixin _$WishlistFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this WishlistFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishlistFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishlistFilterModelCopyWith<WishlistFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistFilterModelCopyWith<$Res> {
  factory $WishlistFilterModelCopyWith(
          WishlistFilterModel value, $Res Function(WishlistFilterModel) then) =
      _$WishlistFilterModelCopyWithImpl<$Res, WishlistFilterModel>;
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class _$WishlistFilterModelCopyWithImpl<$Res, $Val extends WishlistFilterModel>
    implements $WishlistFilterModelCopyWith<$Res> {
  _$WishlistFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishlistFilterModel
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
abstract class _$$WishlistFilterModelImplCopyWith<$Res>
    implements $WishlistFilterModelCopyWith<$Res> {
  factory _$$WishlistFilterModelImplCopyWith(_$WishlistFilterModelImpl value,
          $Res Function(_$WishlistFilterModelImpl) then) =
      __$$WishlistFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class __$$WishlistFilterModelImplCopyWithImpl<$Res>
    extends _$WishlistFilterModelCopyWithImpl<$Res, _$WishlistFilterModelImpl>
    implements _$$WishlistFilterModelImplCopyWith<$Res> {
  __$$WishlistFilterModelImplCopyWithImpl(_$WishlistFilterModelImpl _value,
      $Res Function(_$WishlistFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishlistFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_$WishlistFilterModelImpl(
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
class _$WishlistFilterModelImpl implements _WishlistFilterModel {
  const _$WishlistFilterModelImpl({this.page = 1, this.limit = 10});

  factory _$WishlistFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'WishlistFilterModel(page: $page, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit);

  /// Create a copy of WishlistFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistFilterModelImplCopyWith<_$WishlistFilterModelImpl> get copyWith =>
      __$$WishlistFilterModelImplCopyWithImpl<_$WishlistFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishlistFilterModelImplToJson(
      this,
    );
  }
}

abstract class _WishlistFilterModel implements WishlistFilterModel {
  const factory _WishlistFilterModel({final int page, final int limit}) =
      _$WishlistFilterModelImpl;

  factory _WishlistFilterModel.fromJson(Map<String, dynamic> json) =
      _$WishlistFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;

  /// Create a copy of WishlistFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishlistFilterModelImplCopyWith<_$WishlistFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
