// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthorFilterModel _$AuthorFilterModelFromJson(Map<String, dynamic> json) {
  return _AuthorFilterModel.fromJson(json);
}

/// @nodoc
mixin _$AuthorFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  String? get birthDateRange => throw _privateConstructorUsedError;
  String? get deathDateRange => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;

  /// Serializes this AuthorFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthorFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthorFilterModelCopyWith<AuthorFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorFilterModelCopyWith<$Res> {
  factory $AuthorFilterModelCopyWith(
          AuthorFilterModel value, $Res Function(AuthorFilterModel) then) =
      _$AuthorFilterModelCopyWithImpl<$Res, AuthorFilterModel>;
  @useResult
  $Res call(
      {int page,
      int limit,
      String? birthDateRange,
      String? deathDateRange,
      String? searchQuery});
}

/// @nodoc
class _$AuthorFilterModelCopyWithImpl<$Res, $Val extends AuthorFilterModel>
    implements $AuthorFilterModelCopyWith<$Res> {
  _$AuthorFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthorFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? birthDateRange = freezed,
    Object? deathDateRange = freezed,
    Object? searchQuery = freezed,
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
      birthDateRange: freezed == birthDateRange
          ? _value.birthDateRange
          : birthDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      deathDateRange: freezed == deathDateRange
          ? _value.deathDateRange
          : deathDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthorFilterModelImplCopyWith<$Res>
    implements $AuthorFilterModelCopyWith<$Res> {
  factory _$$AuthorFilterModelImplCopyWith(_$AuthorFilterModelImpl value,
          $Res Function(_$AuthorFilterModelImpl) then) =
      __$$AuthorFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int limit,
      String? birthDateRange,
      String? deathDateRange,
      String? searchQuery});
}

/// @nodoc
class __$$AuthorFilterModelImplCopyWithImpl<$Res>
    extends _$AuthorFilterModelCopyWithImpl<$Res, _$AuthorFilterModelImpl>
    implements _$$AuthorFilterModelImplCopyWith<$Res> {
  __$$AuthorFilterModelImplCopyWithImpl(_$AuthorFilterModelImpl _value,
      $Res Function(_$AuthorFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthorFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? birthDateRange = freezed,
    Object? deathDateRange = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_$AuthorFilterModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      birthDateRange: freezed == birthDateRange
          ? _value.birthDateRange
          : birthDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      deathDateRange: freezed == deathDateRange
          ? _value.deathDateRange
          : deathDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorFilterModelImpl implements _AuthorFilterModel {
  const _$AuthorFilterModelImpl(
      {this.page = 1,
      this.limit = 10,
      this.birthDateRange,
      this.deathDateRange,
      this.searchQuery});

  factory _$AuthorFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  final String? birthDateRange;
  @override
  final String? deathDateRange;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'AuthorFilterModel(page: $page, limit: $limit, birthDateRange: $birthDateRange, deathDateRange: $deathDateRange, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.birthDateRange, birthDateRange) ||
                other.birthDateRange == birthDateRange) &&
            (identical(other.deathDateRange, deathDateRange) ||
                other.deathDateRange == deathDateRange) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, page, limit, birthDateRange, deathDateRange, searchQuery);

  /// Create a copy of AuthorFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorFilterModelImplCopyWith<_$AuthorFilterModelImpl> get copyWith =>
      __$$AuthorFilterModelImplCopyWithImpl<_$AuthorFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorFilterModelImplToJson(
      this,
    );
  }
}

abstract class _AuthorFilterModel implements AuthorFilterModel {
  const factory _AuthorFilterModel(
      {final int page,
      final int limit,
      final String? birthDateRange,
      final String? deathDateRange,
      final String? searchQuery}) = _$AuthorFilterModelImpl;

  factory _AuthorFilterModel.fromJson(Map<String, dynamic> json) =
      _$AuthorFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;
  @override
  String? get birthDateRange;
  @override
  String? get deathDateRange;
  @override
  String? get searchQuery;

  /// Create a copy of AuthorFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorFilterModelImplCopyWith<_$AuthorFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
