// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookFilterModel _$BookFilterModelFromJson(Map<String, dynamic> json) {
  return _BookFilterModel.fromJson(json);
}

/// @nodoc
mixin _$BookFilterModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  String? get sellerId => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get genreId => throw _privateConstructorUsedError;

  /// Serializes this BookFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookFilterModelCopyWith<BookFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookFilterModelCopyWith<$Res> {
  factory $BookFilterModelCopyWith(
          BookFilterModel value, $Res Function(BookFilterModel) then) =
      _$BookFilterModelCopyWithImpl<$Res, BookFilterModel>;
  @useResult
  $Res call(
      {int page,
      int limit,
      String? sellerId,
      String? language,
      String? genreId});
}

/// @nodoc
class _$BookFilterModelCopyWithImpl<$Res, $Val extends BookFilterModel>
    implements $BookFilterModelCopyWith<$Res> {
  _$BookFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? sellerId = freezed,
    Object? language = freezed,
    Object? genreId = freezed,
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
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: freezed == genreId
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookFilterModelImplCopyWith<$Res>
    implements $BookFilterModelCopyWith<$Res> {
  factory _$$BookFilterModelImplCopyWith(_$BookFilterModelImpl value,
          $Res Function(_$BookFilterModelImpl) then) =
      __$$BookFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int limit,
      String? sellerId,
      String? language,
      String? genreId});
}

/// @nodoc
class __$$BookFilterModelImplCopyWithImpl<$Res>
    extends _$BookFilterModelCopyWithImpl<$Res, _$BookFilterModelImpl>
    implements _$$BookFilterModelImplCopyWith<$Res> {
  __$$BookFilterModelImplCopyWithImpl(
      _$BookFilterModelImpl _value, $Res Function(_$BookFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? sellerId = freezed,
    Object? language = freezed,
    Object? genreId = freezed,
  }) {
    return _then(_$BookFilterModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: freezed == genreId
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookFilterModelImpl implements _BookFilterModel {
  const _$BookFilterModelImpl(
      {this.page = 1,
      this.limit = 10,
      this.sellerId,
      this.language,
      this.genreId});

  factory _$BookFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  final String? sellerId;
  @override
  final String? language;
  @override
  final String? genreId;

  @override
  String toString() {
    return 'BookFilterModel(page: $page, limit: $limit, sellerId: $sellerId, language: $language, genreId: $genreId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.genreId, genreId) || other.genreId == genreId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, page, limit, sellerId, language, genreId);

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookFilterModelImplCopyWith<_$BookFilterModelImpl> get copyWith =>
      __$$BookFilterModelImplCopyWithImpl<_$BookFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookFilterModelImplToJson(
      this,
    );
  }
}

abstract class _BookFilterModel implements BookFilterModel {
  const factory _BookFilterModel(
      {final int page,
      final int limit,
      final String? sellerId,
      final String? language,
      final String? genreId}) = _$BookFilterModelImpl;

  factory _BookFilterModel.fromJson(Map<String, dynamic> json) =
      _$BookFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;
  @override
  String? get sellerId;
  @override
  String? get language;
  @override
  String? get genreId;

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookFilterModelImplCopyWith<_$BookFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
