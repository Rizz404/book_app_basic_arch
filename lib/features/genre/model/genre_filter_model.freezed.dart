// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'genre_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GenreFilterModel _$GenreFilterModelFromJson(Map<String, dynamic> json) {
  return _GenreFilterModel.fromJson(json);
}

/// @nodoc
mixin _$GenreFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;

  /// Serializes this GenreFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenreFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenreFilterModelCopyWith<GenreFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreFilterModelCopyWith<$Res> {
  factory $GenreFilterModelCopyWith(
          GenreFilterModel value, $Res Function(GenreFilterModel) then) =
      _$GenreFilterModelCopyWithImpl<$Res, GenreFilterModel>;
  @useResult
  $Res call({int page, int limit, String? searchQuery});
}

/// @nodoc
class _$GenreFilterModelCopyWithImpl<$Res, $Val extends GenreFilterModel>
    implements $GenreFilterModelCopyWith<$Res> {
  _$GenreFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenreFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
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
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenreFilterModelImplCopyWith<$Res>
    implements $GenreFilterModelCopyWith<$Res> {
  factory _$$GenreFilterModelImplCopyWith(_$GenreFilterModelImpl value,
          $Res Function(_$GenreFilterModelImpl) then) =
      __$$GenreFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int limit, String? searchQuery});
}

/// @nodoc
class __$$GenreFilterModelImplCopyWithImpl<$Res>
    extends _$GenreFilterModelCopyWithImpl<$Res, _$GenreFilterModelImpl>
    implements _$$GenreFilterModelImplCopyWith<$Res> {
  __$$GenreFilterModelImplCopyWithImpl(_$GenreFilterModelImpl _value,
      $Res Function(_$GenreFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GenreFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? searchQuery = freezed,
  }) {
    return _then(_$GenreFilterModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenreFilterModelImpl implements _GenreFilterModel {
  const _$GenreFilterModelImpl(
      {this.page = 1, this.limit = 10, this.searchQuery});

  factory _$GenreFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'GenreFilterModel(page: $page, limit: $limit, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, limit, searchQuery);

  /// Create a copy of GenreFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreFilterModelImplCopyWith<_$GenreFilterModelImpl> get copyWith =>
      __$$GenreFilterModelImplCopyWithImpl<_$GenreFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreFilterModelImplToJson(
      this,
    );
  }
}

abstract class _GenreFilterModel implements GenreFilterModel {
  const factory _GenreFilterModel(
      {final int page,
      final int limit,
      final String? searchQuery}) = _$GenreFilterModelImpl;

  factory _GenreFilterModel.fromJson(Map<String, dynamic> json) =
      _$GenreFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;
  @override
  String? get searchQuery;

  /// Create a copy of GenreFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenreFilterModelImplCopyWith<_$GenreFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
