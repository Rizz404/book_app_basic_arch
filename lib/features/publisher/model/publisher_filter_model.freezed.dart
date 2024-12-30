// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publisher_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublisherFilterModel _$PublisherFilterModelFromJson(Map<String, dynamic> json) {
  return _PublisherFilterModel.fromJson(json);
}

/// @nodoc
mixin _$PublisherFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this PublisherFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublisherFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublisherFilterModelCopyWith<PublisherFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublisherFilterModelCopyWith<$Res> {
  factory $PublisherFilterModelCopyWith(PublisherFilterModel value,
          $Res Function(PublisherFilterModel) then) =
      _$PublisherFilterModelCopyWithImpl<$Res, PublisherFilterModel>;
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class _$PublisherFilterModelCopyWithImpl<$Res,
        $Val extends PublisherFilterModel>
    implements $PublisherFilterModelCopyWith<$Res> {
  _$PublisherFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublisherFilterModel
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
abstract class _$$PublisherFilterModelImplCopyWith<$Res>
    implements $PublisherFilterModelCopyWith<$Res> {
  factory _$$PublisherFilterModelImplCopyWith(_$PublisherFilterModelImpl value,
          $Res Function(_$PublisherFilterModelImpl) then) =
      __$$PublisherFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int limit});
}

/// @nodoc
class __$$PublisherFilterModelImplCopyWithImpl<$Res>
    extends _$PublisherFilterModelCopyWithImpl<$Res, _$PublisherFilterModelImpl>
    implements _$$PublisherFilterModelImplCopyWith<$Res> {
  __$$PublisherFilterModelImplCopyWithImpl(_$PublisherFilterModelImpl _value,
      $Res Function(_$PublisherFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublisherFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
  }) {
    return _then(_$PublisherFilterModelImpl(
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
class _$PublisherFilterModelImpl implements _PublisherFilterModel {
  const _$PublisherFilterModelImpl({this.page = 1, this.limit = 10});

  factory _$PublisherFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublisherFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'PublisherFilterModel(page: $page, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublisherFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit);

  /// Create a copy of PublisherFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublisherFilterModelImplCopyWith<_$PublisherFilterModelImpl>
      get copyWith =>
          __$$PublisherFilterModelImplCopyWithImpl<_$PublisherFilterModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublisherFilterModelImplToJson(
      this,
    );
  }
}

abstract class _PublisherFilterModel implements PublisherFilterModel {
  const factory _PublisherFilterModel({final int page, final int limit}) =
      _$PublisherFilterModelImpl;

  factory _PublisherFilterModel.fromJson(Map<String, dynamic> json) =
      _$PublisherFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;

  /// Create a copy of PublisherFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublisherFilterModelImplCopyWith<_$PublisherFilterModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
