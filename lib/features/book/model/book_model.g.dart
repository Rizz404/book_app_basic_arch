// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      title: json['title'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookPictures: (json['bookPictures'] as List<dynamic>?)
          ?.map((e) => BookPictureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      status: json['status'] as String,
      slug: json['slug'] as String,
      isbn: json['isbn'] as String,
      stock: (json['stock'] as num).toInt(),
      price: json['price'] as String,
      fileUrl: json['fileUrl'] as String?,
      publicationDate: DateTime.parse(json['publicationDate'] as String),
      author: BookAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      seller: BookSellerModel.fromJson(json['seller'] as Map<String, dynamic>),
      publisher: BookPublisherModel.fromJson(
          json['publisher'] as Map<String, dynamic>),
      language: json['language'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      wishlistCount: (json['wishlistCount'] as num).toInt(),
      isWishlisted: json['isWishlisted'] as bool,
      originalWishlistStatus: json['originalWishlistStatus'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'title': instance.title,
      'genres': instance.genres,
      'bookPictures': instance.bookPictures,
      'description': instance.description,
      'status': instance.status,
      'slug': instance.slug,
      'isbn': instance.isbn,
      'stock': instance.stock,
      'price': instance.price,
      'fileUrl': instance.fileUrl,
      'publicationDate': instance.publicationDate.toIso8601String(),
      'author': instance.author,
      'seller': instance.seller,
      'publisher': instance.publisher,
      'language': instance.language,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'wishlistCount': instance.wishlistCount,
      'isWishlisted': instance.isWishlisted,
      'originalWishlistStatus': instance.originalWishlistStatus,
    };

_$GenreModelImpl _$$GenreModelImplFromJson(Map<String, dynamic> json) =>
    _$GenreModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$GenreModelImplToJson(_$GenreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$BookPictureModelImpl _$$BookPictureModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookPictureModelImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      isCover: json['isCover'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookPictureModelImplToJson(
        _$BookPictureModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'isCover': instance.isCover,
    };

_$BookAuthorModelImpl _$$BookAuthorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookAuthorModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$BookAuthorModelImplToJson(
        _$BookAuthorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$BookSellerModelImpl _$$BookSellerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookSellerModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$BookSellerModelImplToJson(
        _$BookSellerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'profilePicture': instance.profilePicture,
    };

_$BookPublisherModelImpl _$$BookPublisherModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookPublisherModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      website:
          (json['website'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$BookPublisherModelImplToJson(
        _$BookPublisherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'website': instance.website,
    };

_$CreateBookModelImpl _$$CreateBookModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateBookModelImpl(
      title: json['title'] as String,
      genreIds:
          (json['genreIds'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      isbn: json['isbn'] as String,
      stock: (json['stock'] as num).toInt(),
      price: json['price'] as String,
      fileUrl: json['fileUrl'] as String?,
      publicationDate: DateTime.parse(json['publicationDate'] as String),
      authorId: json['authorId'] as String,
      publisherId: json['publisherId'] as String,
      language: json['language'] as String,
    );

Map<String, dynamic> _$$CreateBookModelImplToJson(
        _$CreateBookModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'genreIds': instance.genreIds,
      'description': instance.description,
      'isbn': instance.isbn,
      'stock': instance.stock,
      'price': instance.price,
      'fileUrl': instance.fileUrl,
      'publicationDate': instance.publicationDate.toIso8601String(),
      'authorId': instance.authorId,
      'publisherId': instance.publisherId,
      'language': instance.language,
    };

_$UpdateBookModelImpl _$$UpdateBookModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateBookModelImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      genreIds: (json['genreIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      isbn: json['isbn'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      price: json['price'] as String?,
      fileUrl: json['fileUrl'] as String?,
      publicationDate: json['publicationDate'] == null
          ? null
          : DateTime.parse(json['publicationDate'] as String),
      authorId: json['authorId'] as String?,
      publisherId: json['publisherId'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$$UpdateBookModelImplToJson(
        _$UpdateBookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'genreIds': instance.genreIds,
      'description': instance.description,
      'isbn': instance.isbn,
      'stock': instance.stock,
      'price': instance.price,
      'fileUrl': instance.fileUrl,
      'publicationDate': instance.publicationDate?.toIso8601String(),
      'authorId': instance.authorId,
      'publisherId': instance.publisherId,
      'language': instance.language,
    };
