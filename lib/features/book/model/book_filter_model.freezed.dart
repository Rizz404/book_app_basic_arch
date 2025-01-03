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
  BookStatus? get status => throw _privateConstructorUsedError;
  String? get sellerId => throw _privateConstructorUsedError;
  String? get genreId => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  String? get publisherId => throw _privateConstructorUsedError;
  String? get publicationDateRange => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;

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
      BookStatus? status,
      String? sellerId,
      String? genreId,
      String? authorId,
      String? publisherId,
      String? publicationDateRange,
      String? language,
      String? searchQuery});
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
    Object? status = freezed,
    Object? sellerId = freezed,
    Object? genreId = freezed,
    Object? authorId = freezed,
    Object? publisherId = freezed,
    Object? publicationDateRange = freezed,
    Object? language = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookStatus?,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: freezed == genreId
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      publisherId: freezed == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDateRange: freezed == publicationDateRange
          ? _value.publicationDateRange
          : publicationDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
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
      BookStatus? status,
      String? sellerId,
      String? genreId,
      String? authorId,
      String? publisherId,
      String? publicationDateRange,
      String? language,
      String? searchQuery});
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
    Object? status = freezed,
    Object? sellerId = freezed,
    Object? genreId = freezed,
    Object? authorId = freezed,
    Object? publisherId = freezed,
    Object? publicationDateRange = freezed,
    Object? language = freezed,
    Object? searchQuery = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookStatus?,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: freezed == genreId
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      publisherId: freezed == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDateRange: freezed == publicationDateRange
          ? _value.publicationDateRange
          : publicationDateRange // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
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
class _$BookFilterModelImpl implements _BookFilterModel {
  const _$BookFilterModelImpl(
      {this.page = 1,
      this.limit = 10,
      this.status,
      this.sellerId,
      this.genreId,
      this.authorId,
      this.publisherId,
      this.publicationDateRange,
      this.language,
      this.searchQuery});

  factory _$BookFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookFilterModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  final BookStatus? status;
  @override
  final String? sellerId;
  @override
  final String? genreId;
  @override
  final String? authorId;
  @override
  final String? publisherId;
  @override
  final String? publicationDateRange;
  @override
  final String? language;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'BookFilterModel(page: $page, limit: $limit, status: $status, sellerId: $sellerId, genreId: $genreId, authorId: $authorId, publisherId: $publisherId, publicationDateRange: $publicationDateRange, language: $language, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookFilterModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.genreId, genreId) || other.genreId == genreId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.publisherId, publisherId) ||
                other.publisherId == publisherId) &&
            (identical(other.publicationDateRange, publicationDateRange) ||
                other.publicationDateRange == publicationDateRange) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      limit,
      status,
      sellerId,
      genreId,
      authorId,
      publisherId,
      publicationDateRange,
      language,
      searchQuery);

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
      final BookStatus? status,
      final String? sellerId,
      final String? genreId,
      final String? authorId,
      final String? publisherId,
      final String? publicationDateRange,
      final String? language,
      final String? searchQuery}) = _$BookFilterModelImpl;

  factory _BookFilterModel.fromJson(Map<String, dynamic> json) =
      _$BookFilterModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;
  @override
  BookStatus? get status;
  @override
  String? get sellerId;
  @override
  String? get genreId;
  @override
  String? get authorId;
  @override
  String? get publisherId;
  @override
  String? get publicationDateRange;
  @override
  String? get language;
  @override
  String? get searchQuery;

  /// Create a copy of BookFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookFilterModelImplCopyWith<_$BookFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
