// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  String get id => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<GenreModel> get genres => throw _privateConstructorUsedError;
  List<BookPictureModel>? get bookPictures =>
      throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get isbn => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  DateTime get publicationDate => throw _privateConstructorUsedError;
  BookAuthorModel get author => throw _privateConstructorUsedError;
  BookSellerModel get seller => throw _privateConstructorUsedError;
  BookPublisherModel get publisher => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String title,
      List<GenreModel> genres,
      List<BookPictureModel>? bookPictures,
      String description,
      String status,
      String slug,
      String isbn,
      int stock,
      String price,
      String? fileUrl,
      DateTime publicationDate,
      BookAuthorModel author,
      BookSellerModel seller,
      BookPublisherModel publisher,
      String language});

  $BookAuthorModelCopyWith<$Res> get author;
  $BookSellerModelCopyWith<$Res> get seller;
  $BookPublisherModelCopyWith<$Res> get publisher;
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? genres = null,
    Object? bookPictures = freezed,
    Object? description = null,
    Object? status = null,
    Object? slug = null,
    Object? isbn = null,
    Object? stock = null,
    Object? price = null,
    Object? fileUrl = freezed,
    Object? publicationDate = null,
    Object? author = null,
    Object? seller = null,
    Object? publisher = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>,
      bookPictures: freezed == bookPictures
          ? _value.bookPictures
          : bookPictures // ignore: cast_nullable_to_non_nullable
              as List<BookPictureModel>?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: null == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as BookAuthorModel,
      seller: null == seller
          ? _value.seller
          : seller // ignore: cast_nullable_to_non_nullable
              as BookSellerModel,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as BookPublisherModel,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookAuthorModelCopyWith<$Res> get author {
    return $BookAuthorModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookSellerModelCopyWith<$Res> get seller {
    return $BookSellerModelCopyWith<$Res>(_value.seller, (value) {
      return _then(_value.copyWith(seller: value) as $Val);
    });
  }

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookPublisherModelCopyWith<$Res> get publisher {
    return $BookPublisherModelCopyWith<$Res>(_value.publisher, (value) {
      return _then(_value.copyWith(publisher: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookModelImplCopyWith<$Res>
    implements $BookModelCopyWith<$Res> {
  factory _$$BookModelImplCopyWith(
          _$BookModelImpl value, $Res Function(_$BookModelImpl) then) =
      __$$BookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String title,
      List<GenreModel> genres,
      List<BookPictureModel>? bookPictures,
      String description,
      String status,
      String slug,
      String isbn,
      int stock,
      String price,
      String? fileUrl,
      DateTime publicationDate,
      BookAuthorModel author,
      BookSellerModel seller,
      BookPublisherModel publisher,
      String language});

  @override
  $BookAuthorModelCopyWith<$Res> get author;
  @override
  $BookSellerModelCopyWith<$Res> get seller;
  @override
  $BookPublisherModelCopyWith<$Res> get publisher;
}

/// @nodoc
class __$$BookModelImplCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$BookModelImpl>
    implements _$$BookModelImplCopyWith<$Res> {
  __$$BookModelImplCopyWithImpl(
      _$BookModelImpl _value, $Res Function(_$BookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? genres = null,
    Object? bookPictures = freezed,
    Object? description = null,
    Object? status = null,
    Object? slug = null,
    Object? isbn = null,
    Object? stock = null,
    Object? price = null,
    Object? fileUrl = freezed,
    Object? publicationDate = null,
    Object? author = null,
    Object? seller = null,
    Object? publisher = null,
    Object? language = null,
  }) {
    return _then(_$BookModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>,
      bookPictures: freezed == bookPictures
          ? _value._bookPictures
          : bookPictures // ignore: cast_nullable_to_non_nullable
              as List<BookPictureModel>?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: null == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as BookAuthorModel,
      seller: null == seller
          ? _value.seller
          : seller // ignore: cast_nullable_to_non_nullable
              as BookSellerModel,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as BookPublisherModel,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookModelImpl implements _BookModel {
  const _$BookModelImpl(
      {required this.id,
      required this.sellerId,
      required this.title,
      required final List<GenreModel> genres,
      final List<BookPictureModel>? bookPictures,
      required this.description,
      required this.status,
      required this.slug,
      required this.isbn,
      required this.stock,
      required this.price,
      this.fileUrl,
      required this.publicationDate,
      required this.author,
      required this.seller,
      required this.publisher,
      required this.language})
      : _genres = genres,
        _bookPictures = bookPictures;

  factory _$BookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sellerId;
  @override
  final String title;
  final List<GenreModel> _genres;
  @override
  List<GenreModel> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<BookPictureModel>? _bookPictures;
  @override
  List<BookPictureModel>? get bookPictures {
    final value = _bookPictures;
    if (value == null) return null;
    if (_bookPictures is EqualUnmodifiableListView) return _bookPictures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String description;
  @override
  final String status;
  @override
  final String slug;
  @override
  final String isbn;
  @override
  final int stock;
  @override
  final String price;
  @override
  final String? fileUrl;
  @override
  final DateTime publicationDate;
  @override
  final BookAuthorModel author;
  @override
  final BookSellerModel seller;
  @override
  final BookPublisherModel publisher;
  @override
  final String language;

  @override
  String toString() {
    return 'BookModel(id: $id, sellerId: $sellerId, title: $title, genres: $genres, bookPictures: $bookPictures, description: $description, status: $status, slug: $slug, isbn: $isbn, stock: $stock, price: $price, fileUrl: $fileUrl, publicationDate: $publicationDate, author: $author, seller: $seller, publisher: $publisher, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality()
                .equals(other._bookPictures, _bookPictures) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.publicationDate, publicationDate) ||
                other.publicationDate == publicationDate) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.seller, seller) || other.seller == seller) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sellerId,
      title,
      const DeepCollectionEquality().hash(_genres),
      const DeepCollectionEquality().hash(_bookPictures),
      description,
      status,
      slug,
      isbn,
      stock,
      price,
      fileUrl,
      publicationDate,
      author,
      seller,
      publisher,
      language);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      __$$BookModelImplCopyWithImpl<_$BookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookModelImplToJson(
      this,
    );
  }
}

abstract class _BookModel implements BookModel {
  const factory _BookModel(
      {required final String id,
      required final String sellerId,
      required final String title,
      required final List<GenreModel> genres,
      final List<BookPictureModel>? bookPictures,
      required final String description,
      required final String status,
      required final String slug,
      required final String isbn,
      required final int stock,
      required final String price,
      final String? fileUrl,
      required final DateTime publicationDate,
      required final BookAuthorModel author,
      required final BookSellerModel seller,
      required final BookPublisherModel publisher,
      required final String language}) = _$BookModelImpl;

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$BookModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sellerId;
  @override
  String get title;
  @override
  List<GenreModel> get genres;
  @override
  List<BookPictureModel>? get bookPictures;
  @override
  String get description;
  @override
  String get status;
  @override
  String get slug;
  @override
  String get isbn;
  @override
  int get stock;
  @override
  String get price;
  @override
  String? get fileUrl;
  @override
  DateTime get publicationDate;
  @override
  BookAuthorModel get author;
  @override
  BookSellerModel get seller;
  @override
  BookPublisherModel get publisher;
  @override
  String get language;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) {
  return _GenreModel.fromJson(json);
}

/// @nodoc
mixin _$GenreModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this GenreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenreModelCopyWith<GenreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreModelCopyWith<$Res> {
  factory $GenreModelCopyWith(
          GenreModel value, $Res Function(GenreModel) then) =
      _$GenreModelCopyWithImpl<$Res, GenreModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$GenreModelCopyWithImpl<$Res, $Val extends GenreModel>
    implements $GenreModelCopyWith<$Res> {
  _$GenreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenreModelImplCopyWith<$Res>
    implements $GenreModelCopyWith<$Res> {
  factory _$$GenreModelImplCopyWith(
          _$GenreModelImpl value, $Res Function(_$GenreModelImpl) then) =
      __$$GenreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$GenreModelImplCopyWithImpl<$Res>
    extends _$GenreModelCopyWithImpl<$Res, _$GenreModelImpl>
    implements _$$GenreModelImplCopyWith<$Res> {
  __$$GenreModelImplCopyWithImpl(
      _$GenreModelImpl _value, $Res Function(_$GenreModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GenreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$GenreModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$GenreModelImpl implements _GenreModel {
  const _$GenreModelImpl({required this.id, required this.name});

  factory _$GenreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of GenreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreModelImplCopyWith<_$GenreModelImpl> get copyWith =>
      __$$GenreModelImplCopyWithImpl<_$GenreModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreModelImplToJson(
      this,
    );
  }
}

abstract class _GenreModel implements GenreModel {
  const factory _GenreModel(
      {required final String id,
      required final String name}) = _$GenreModelImpl;

  factory _GenreModel.fromJson(Map<String, dynamic> json) =
      _$GenreModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of GenreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenreModelImplCopyWith<_$GenreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookPictureModel _$BookPictureModelFromJson(Map<String, dynamic> json) {
  return _BookPictureModel.fromJson(json);
}

/// @nodoc
mixin _$BookPictureModel {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  bool get isCover => throw _privateConstructorUsedError;

  /// Serializes this BookPictureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookPictureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookPictureModelCopyWith<BookPictureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookPictureModelCopyWith<$Res> {
  factory $BookPictureModelCopyWith(
          BookPictureModel value, $Res Function(BookPictureModel) then) =
      _$BookPictureModelCopyWithImpl<$Res, BookPictureModel>;
  @useResult
  $Res call({String id, String url, bool isCover});
}

/// @nodoc
class _$BookPictureModelCopyWithImpl<$Res, $Val extends BookPictureModel>
    implements $BookPictureModelCopyWith<$Res> {
  _$BookPictureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookPictureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? isCover = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      isCover: null == isCover
          ? _value.isCover
          : isCover // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookPictureModelImplCopyWith<$Res>
    implements $BookPictureModelCopyWith<$Res> {
  factory _$$BookPictureModelImplCopyWith(_$BookPictureModelImpl value,
          $Res Function(_$BookPictureModelImpl) then) =
      __$$BookPictureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, bool isCover});
}

/// @nodoc
class __$$BookPictureModelImplCopyWithImpl<$Res>
    extends _$BookPictureModelCopyWithImpl<$Res, _$BookPictureModelImpl>
    implements _$$BookPictureModelImplCopyWith<$Res> {
  __$$BookPictureModelImplCopyWithImpl(_$BookPictureModelImpl _value,
      $Res Function(_$BookPictureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookPictureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? isCover = null,
  }) {
    return _then(_$BookPictureModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      isCover: null == isCover
          ? _value.isCover
          : isCover // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookPictureModelImpl implements _BookPictureModel {
  const _$BookPictureModelImpl(
      {required this.id, required this.url, this.isCover = false});

  factory _$BookPictureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookPictureModelImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  @JsonKey()
  final bool isCover;

  @override
  String toString() {
    return 'BookPictureModel(id: $id, url: $url, isCover: $isCover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookPictureModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isCover, isCover) || other.isCover == isCover));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, isCover);

  /// Create a copy of BookPictureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookPictureModelImplCopyWith<_$BookPictureModelImpl> get copyWith =>
      __$$BookPictureModelImplCopyWithImpl<_$BookPictureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookPictureModelImplToJson(
      this,
    );
  }
}

abstract class _BookPictureModel implements BookPictureModel {
  const factory _BookPictureModel(
      {required final String id,
      required final String url,
      final bool isCover}) = _$BookPictureModelImpl;

  factory _BookPictureModel.fromJson(Map<String, dynamic> json) =
      _$BookPictureModelImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  bool get isCover;

  /// Create a copy of BookPictureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookPictureModelImplCopyWith<_$BookPictureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookAuthorModel _$BookAuthorModelFromJson(Map<String, dynamic> json) {
  return _BookAuthorModel.fromJson(json);
}

/// @nodoc
mixin _$BookAuthorModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BookAuthorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookAuthorModelCopyWith<BookAuthorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookAuthorModelCopyWith<$Res> {
  factory $BookAuthorModelCopyWith(
          BookAuthorModel value, $Res Function(BookAuthorModel) then) =
      _$BookAuthorModelCopyWithImpl<$Res, BookAuthorModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$BookAuthorModelCopyWithImpl<$Res, $Val extends BookAuthorModel>
    implements $BookAuthorModelCopyWith<$Res> {
  _$BookAuthorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookAuthorModelImplCopyWith<$Res>
    implements $BookAuthorModelCopyWith<$Res> {
  factory _$$BookAuthorModelImplCopyWith(_$BookAuthorModelImpl value,
          $Res Function(_$BookAuthorModelImpl) then) =
      __$$BookAuthorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$BookAuthorModelImplCopyWithImpl<$Res>
    extends _$BookAuthorModelCopyWithImpl<$Res, _$BookAuthorModelImpl>
    implements _$$BookAuthorModelImplCopyWith<$Res> {
  __$$BookAuthorModelImplCopyWithImpl(
      _$BookAuthorModelImpl _value, $Res Function(_$BookAuthorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$BookAuthorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$BookAuthorModelImpl implements _BookAuthorModel {
  const _$BookAuthorModelImpl({required this.id, required this.name});

  factory _$BookAuthorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookAuthorModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'BookAuthorModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookAuthorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BookAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookAuthorModelImplCopyWith<_$BookAuthorModelImpl> get copyWith =>
      __$$BookAuthorModelImplCopyWithImpl<_$BookAuthorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookAuthorModelImplToJson(
      this,
    );
  }
}

abstract class _BookAuthorModel implements BookAuthorModel {
  const factory _BookAuthorModel(
      {required final String id,
      required final String name}) = _$BookAuthorModelImpl;

  factory _BookAuthorModel.fromJson(Map<String, dynamic> json) =
      _$BookAuthorModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of BookAuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookAuthorModelImplCopyWith<_$BookAuthorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookSellerModel _$BookSellerModelFromJson(Map<String, dynamic> json) {
  return _BookSellerModel.fromJson(json);
}

/// @nodoc
mixin _$BookSellerModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;

  /// Serializes this BookSellerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookSellerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookSellerModelCopyWith<BookSellerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookSellerModelCopyWith<$Res> {
  factory $BookSellerModelCopyWith(
          BookSellerModel value, $Res Function(BookSellerModel) then) =
      _$BookSellerModelCopyWithImpl<$Res, BookSellerModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      bool isVerified,
      String? profilePicture});
}

/// @nodoc
class _$BookSellerModelCopyWithImpl<$Res, $Val extends BookSellerModel>
    implements $BookSellerModelCopyWith<$Res> {
  _$BookSellerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookSellerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? isVerified = null,
    Object? profilePicture = freezed,
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
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookSellerModelImplCopyWith<$Res>
    implements $BookSellerModelCopyWith<$Res> {
  factory _$$BookSellerModelImplCopyWith(_$BookSellerModelImpl value,
          $Res Function(_$BookSellerModelImpl) then) =
      __$$BookSellerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      bool isVerified,
      String? profilePicture});
}

/// @nodoc
class __$$BookSellerModelImplCopyWithImpl<$Res>
    extends _$BookSellerModelCopyWithImpl<$Res, _$BookSellerModelImpl>
    implements _$$BookSellerModelImplCopyWith<$Res> {
  __$$BookSellerModelImplCopyWithImpl(
      _$BookSellerModelImpl _value, $Res Function(_$BookSellerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookSellerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? isVerified = null,
    Object? profilePicture = freezed,
  }) {
    return _then(_$BookSellerModelImpl(
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
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookSellerModelImpl implements _BookSellerModel {
  const _$BookSellerModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      this.isVerified = false,
      this.profilePicture});

  factory _$BookSellerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookSellerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final String? profilePicture;

  @override
  String toString() {
    return 'BookSellerModel(id: $id, username: $username, email: $email, isVerified: $isVerified, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSellerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, email, isVerified, profilePicture);

  /// Create a copy of BookSellerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSellerModelImplCopyWith<_$BookSellerModelImpl> get copyWith =>
      __$$BookSellerModelImplCopyWithImpl<_$BookSellerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookSellerModelImplToJson(
      this,
    );
  }
}

abstract class _BookSellerModel implements BookSellerModel {
  const factory _BookSellerModel(
      {required final String id,
      required final String username,
      required final String email,
      final bool isVerified,
      final String? profilePicture}) = _$BookSellerModelImpl;

  factory _BookSellerModel.fromJson(Map<String, dynamic> json) =
      _$BookSellerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  bool get isVerified;
  @override
  String? get profilePicture;

  /// Create a copy of BookSellerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookSellerModelImplCopyWith<_$BookSellerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookPublisherModel _$BookPublisherModelFromJson(Map<String, dynamic> json) {
  return _BookPublisherModel.fromJson(json);
}

/// @nodoc
mixin _$BookPublisherModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<String> get website => throw _privateConstructorUsedError;

  /// Serializes this BookPublisherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookPublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookPublisherModelCopyWith<BookPublisherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookPublisherModelCopyWith<$Res> {
  factory $BookPublisherModelCopyWith(
          BookPublisherModel value, $Res Function(BookPublisherModel) then) =
      _$BookPublisherModelCopyWithImpl<$Res, BookPublisherModel>;
  @useResult
  $Res call({String id, String name, String email, List<String> website});
}

/// @nodoc
class _$BookPublisherModelCopyWithImpl<$Res, $Val extends BookPublisherModel>
    implements $BookPublisherModelCopyWith<$Res> {
  _$BookPublisherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookPublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? website = null,
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
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookPublisherModelImplCopyWith<$Res>
    implements $BookPublisherModelCopyWith<$Res> {
  factory _$$BookPublisherModelImplCopyWith(_$BookPublisherModelImpl value,
          $Res Function(_$BookPublisherModelImpl) then) =
      __$$BookPublisherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String email, List<String> website});
}

/// @nodoc
class __$$BookPublisherModelImplCopyWithImpl<$Res>
    extends _$BookPublisherModelCopyWithImpl<$Res, _$BookPublisherModelImpl>
    implements _$$BookPublisherModelImplCopyWith<$Res> {
  __$$BookPublisherModelImplCopyWithImpl(_$BookPublisherModelImpl _value,
      $Res Function(_$BookPublisherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookPublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? website = null,
  }) {
    return _then(_$BookPublisherModelImpl(
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
      website: null == website
          ? _value._website
          : website // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookPublisherModelImpl implements _BookPublisherModel {
  const _$BookPublisherModelImpl(
      {required this.id,
      required this.name,
      required this.email,
      required final List<String> website})
      : _website = website;

  factory _$BookPublisherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookPublisherModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  final List<String> _website;
  @override
  List<String> get website {
    if (_website is EqualUnmodifiableListView) return _website;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_website);
  }

  @override
  String toString() {
    return 'BookPublisherModel(id: $id, name: $name, email: $email, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookPublisherModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._website, _website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email,
      const DeepCollectionEquality().hash(_website));

  /// Create a copy of BookPublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookPublisherModelImplCopyWith<_$BookPublisherModelImpl> get copyWith =>
      __$$BookPublisherModelImplCopyWithImpl<_$BookPublisherModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookPublisherModelImplToJson(
      this,
    );
  }
}

abstract class _BookPublisherModel implements BookPublisherModel {
  const factory _BookPublisherModel(
      {required final String id,
      required final String name,
      required final String email,
      required final List<String> website}) = _$BookPublisherModelImpl;

  factory _BookPublisherModel.fromJson(Map<String, dynamic> json) =
      _$BookPublisherModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  List<String> get website;

  /// Create a copy of BookPublisherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookPublisherModelImplCopyWith<_$BookPublisherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateBookModel _$CreateBookModelFromJson(Map<String, dynamic> json) {
  return _CreateBookModel.fromJson(json);
}

/// @nodoc
mixin _$CreateBookModel {
  String get title => throw _privateConstructorUsedError;
  List<String> get genreIds => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get isbn => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  DateTime get publicationDate => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get publisherId => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this CreateBookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateBookModelCopyWith<CreateBookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateBookModelCopyWith<$Res> {
  factory $CreateBookModelCopyWith(
          CreateBookModel value, $Res Function(CreateBookModel) then) =
      _$CreateBookModelCopyWithImpl<$Res, CreateBookModel>;
  @useResult
  $Res call(
      {String title,
      List<String> genreIds,
      String description,
      String isbn,
      int stock,
      String price,
      String? fileUrl,
      DateTime publicationDate,
      String authorId,
      String publisherId,
      String language});
}

/// @nodoc
class _$CreateBookModelCopyWithImpl<$Res, $Val extends CreateBookModel>
    implements $CreateBookModelCopyWith<$Res> {
  _$CreateBookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? genreIds = null,
    Object? description = null,
    Object? isbn = null,
    Object? stock = null,
    Object? price = null,
    Object? fileUrl = freezed,
    Object? publicationDate = null,
    Object? authorId = null,
    Object? publisherId = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: null == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      publisherId: null == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateBookModelImplCopyWith<$Res>
    implements $CreateBookModelCopyWith<$Res> {
  factory _$$CreateBookModelImplCopyWith(_$CreateBookModelImpl value,
          $Res Function(_$CreateBookModelImpl) then) =
      __$$CreateBookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> genreIds,
      String description,
      String isbn,
      int stock,
      String price,
      String? fileUrl,
      DateTime publicationDate,
      String authorId,
      String publisherId,
      String language});
}

/// @nodoc
class __$$CreateBookModelImplCopyWithImpl<$Res>
    extends _$CreateBookModelCopyWithImpl<$Res, _$CreateBookModelImpl>
    implements _$$CreateBookModelImplCopyWith<$Res> {
  __$$CreateBookModelImplCopyWithImpl(
      _$CreateBookModelImpl _value, $Res Function(_$CreateBookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? genreIds = null,
    Object? description = null,
    Object? isbn = null,
    Object? stock = null,
    Object? price = null,
    Object? fileUrl = freezed,
    Object? publicationDate = null,
    Object? authorId = null,
    Object? publisherId = null,
    Object? language = null,
  }) {
    return _then(_$CreateBookModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isbn: null == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: null == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      publisherId: null == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateBookModelImpl implements _CreateBookModel {
  const _$CreateBookModelImpl(
      {required this.title,
      required final List<String> genreIds,
      required this.description,
      required this.isbn,
      required this.stock,
      required this.price,
      this.fileUrl,
      required this.publicationDate,
      required this.authorId,
      required this.publisherId,
      required this.language})
      : _genreIds = genreIds;

  factory _$CreateBookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateBookModelImplFromJson(json);

  @override
  final String title;
  final List<String> _genreIds;
  @override
  List<String> get genreIds {
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genreIds);
  }

  @override
  final String description;
  @override
  final String isbn;
  @override
  final int stock;
  @override
  final String price;
  @override
  final String? fileUrl;
  @override
  final DateTime publicationDate;
  @override
  final String authorId;
  @override
  final String publisherId;
  @override
  final String language;

  @override
  String toString() {
    return 'CreateBookModel(title: $title, genreIds: $genreIds, description: $description, isbn: $isbn, stock: $stock, price: $price, fileUrl: $fileUrl, publicationDate: $publicationDate, authorId: $authorId, publisherId: $publisherId, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateBookModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.publicationDate, publicationDate) ||
                other.publicationDate == publicationDate) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.publisherId, publisherId) ||
                other.publisherId == publisherId) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_genreIds),
      description,
      isbn,
      stock,
      price,
      fileUrl,
      publicationDate,
      authorId,
      publisherId,
      language);

  /// Create a copy of CreateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBookModelImplCopyWith<_$CreateBookModelImpl> get copyWith =>
      __$$CreateBookModelImplCopyWithImpl<_$CreateBookModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateBookModelImplToJson(
      this,
    );
  }
}

abstract class _CreateBookModel implements CreateBookModel {
  const factory _CreateBookModel(
      {required final String title,
      required final List<String> genreIds,
      required final String description,
      required final String isbn,
      required final int stock,
      required final String price,
      final String? fileUrl,
      required final DateTime publicationDate,
      required final String authorId,
      required final String publisherId,
      required final String language}) = _$CreateBookModelImpl;

  factory _CreateBookModel.fromJson(Map<String, dynamic> json) =
      _$CreateBookModelImpl.fromJson;

  @override
  String get title;
  @override
  List<String> get genreIds;
  @override
  String get description;
  @override
  String get isbn;
  @override
  int get stock;
  @override
  String get price;
  @override
  String? get fileUrl;
  @override
  DateTime get publicationDate;
  @override
  String get authorId;
  @override
  String get publisherId;
  @override
  String get language;

  /// Create a copy of CreateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateBookModelImplCopyWith<_$CreateBookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateBookModel _$UpdateBookModelFromJson(Map<String, dynamic> json) {
  return _UpdateBookModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateBookModel {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<String>? get genreIds => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get isbn => throw _privateConstructorUsedError;
  int? get stock => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  DateTime? get publicationDate => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  String? get publisherId => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;

  /// Serializes this UpdateBookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateBookModelCopyWith<UpdateBookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateBookModelCopyWith<$Res> {
  factory $UpdateBookModelCopyWith(
          UpdateBookModel value, $Res Function(UpdateBookModel) then) =
      _$UpdateBookModelCopyWithImpl<$Res, UpdateBookModel>;
  @useResult
  $Res call(
      {String id,
      String? title,
      List<String>? genreIds,
      String? description,
      String? isbn,
      int? stock,
      String? price,
      String? fileUrl,
      DateTime? publicationDate,
      String? authorId,
      String? publisherId,
      String? language});
}

/// @nodoc
class _$UpdateBookModelCopyWithImpl<$Res, $Val extends UpdateBookModel>
    implements $UpdateBookModelCopyWith<$Res> {
  _$UpdateBookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? genreIds = freezed,
    Object? description = freezed,
    Object? isbn = freezed,
    Object? stock = freezed,
    Object? price = freezed,
    Object? fileUrl = freezed,
    Object? publicationDate = freezed,
    Object? authorId = freezed,
    Object? publisherId = freezed,
    Object? language = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: freezed == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      publisherId: freezed == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateBookModelImplCopyWith<$Res>
    implements $UpdateBookModelCopyWith<$Res> {
  factory _$$UpdateBookModelImplCopyWith(_$UpdateBookModelImpl value,
          $Res Function(_$UpdateBookModelImpl) then) =
      __$$UpdateBookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      List<String>? genreIds,
      String? description,
      String? isbn,
      int? stock,
      String? price,
      String? fileUrl,
      DateTime? publicationDate,
      String? authorId,
      String? publisherId,
      String? language});
}

/// @nodoc
class __$$UpdateBookModelImplCopyWithImpl<$Res>
    extends _$UpdateBookModelCopyWithImpl<$Res, _$UpdateBookModelImpl>
    implements _$$UpdateBookModelImplCopyWith<$Res> {
  __$$UpdateBookModelImplCopyWithImpl(
      _$UpdateBookModelImpl _value, $Res Function(_$UpdateBookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? genreIds = freezed,
    Object? description = freezed,
    Object? isbn = freezed,
    Object? stock = freezed,
    Object? price = freezed,
    Object? fileUrl = freezed,
    Object? publicationDate = freezed,
    Object? authorId = freezed,
    Object? publisherId = freezed,
    Object? language = freezed,
  }) {
    return _then(_$UpdateBookModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genreIds: freezed == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isbn: freezed == isbn
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publicationDate: freezed == publicationDate
          ? _value.publicationDate
          : publicationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      publisherId: freezed == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateBookModelImpl implements _UpdateBookModel {
  const _$UpdateBookModelImpl(
      {required this.id,
      this.title,
      final List<String>? genreIds,
      this.description,
      this.isbn,
      this.stock,
      this.price,
      this.fileUrl,
      this.publicationDate,
      this.authorId,
      this.publisherId,
      this.language})
      : _genreIds = genreIds;

  factory _$UpdateBookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateBookModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  final List<String>? _genreIds;
  @override
  List<String>? get genreIds {
    final value = _genreIds;
    if (value == null) return null;
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? description;
  @override
  final String? isbn;
  @override
  final int? stock;
  @override
  final String? price;
  @override
  final String? fileUrl;
  @override
  final DateTime? publicationDate;
  @override
  final String? authorId;
  @override
  final String? publisherId;
  @override
  final String? language;

  @override
  String toString() {
    return 'UpdateBookModel(id: $id, title: $title, genreIds: $genreIds, description: $description, isbn: $isbn, stock: $stock, price: $price, fileUrl: $fileUrl, publicationDate: $publicationDate, authorId: $authorId, publisherId: $publisherId, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBookModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isbn, isbn) || other.isbn == isbn) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.publicationDate, publicationDate) ||
                other.publicationDate == publicationDate) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.publisherId, publisherId) ||
                other.publisherId == publisherId) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_genreIds),
      description,
      isbn,
      stock,
      price,
      fileUrl,
      publicationDate,
      authorId,
      publisherId,
      language);

  /// Create a copy of UpdateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookModelImplCopyWith<_$UpdateBookModelImpl> get copyWith =>
      __$$UpdateBookModelImplCopyWithImpl<_$UpdateBookModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateBookModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateBookModel implements UpdateBookModel {
  const factory _UpdateBookModel(
      {required final String id,
      final String? title,
      final List<String>? genreIds,
      final String? description,
      final String? isbn,
      final int? stock,
      final String? price,
      final String? fileUrl,
      final DateTime? publicationDate,
      final String? authorId,
      final String? publisherId,
      final String? language}) = _$UpdateBookModelImpl;

  factory _UpdateBookModel.fromJson(Map<String, dynamic> json) =
      _$UpdateBookModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  List<String>? get genreIds;
  @override
  String? get description;
  @override
  String? get isbn;
  @override
  int? get stock;
  @override
  String? get price;
  @override
  String? get fileUrl;
  @override
  DateTime? get publicationDate;
  @override
  String? get authorId;
  @override
  String? get publisherId;
  @override
  String? get language;

  /// Create a copy of UpdateBookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookModelImplCopyWith<_$UpdateBookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
