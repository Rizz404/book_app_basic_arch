import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/network/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/book/model/book_filter_model.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';

class BookServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<BookModel>> createBook(CreateBookModel book) async {
    try {
      return await _dioClient.post(
        '/books',
        data: book,
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> getBooks(
    BookFilterModel bookFilterModel,
  ) async {
    try {
      final queryParameters = {
        'page': bookFilterModel.page,
        'limit': bookFilterModel.limit,
        if (bookFilterModel.status != null) 'status': bookFilterModel.status,
        if (bookFilterModel.sellerId != null)
          'sellerId': bookFilterModel.sellerId,
        if (bookFilterModel.genreId != null) 'genreId': bookFilterModel.genreId,
        if (bookFilterModel.authorId != null)
          'authorId': bookFilterModel.authorId,
        if (bookFilterModel.publisherId != null)
          'publisherId': bookFilterModel.publisherId,
        if (bookFilterModel.publicationDateRange != null)
          'publicationDateRange': bookFilterModel.publicationDateRange,
        if (bookFilterModel.language != null)
          'language': bookFilterModel.language,
      };

      return await _dioClient.get(
        '/books',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final book = BookModel.fromJson(item as Map<String, dynamic>);
          return book.copyWith(originalWishlistStatus: book.isWishlisted);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<BookModel>> getBookById(String id) async {
    try {
      return await _dioClient.get(
        '/books/$id',
        fromJsonT: (json) {
          final book = BookModel.fromJson(json as Map<String, dynamic>);
          return book.copyWith(originalWishlistStatus: book.isWishlisted);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> searchBooksByTitle({
    int page = 1,
    int limit = 10,
    required String title,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        'title': title,
      };

      return await _dioClient.get(
        '/books/search',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final book = BookModel.fromJson(item as Map<String, dynamic>);
          return book.copyWith(originalWishlistStatus: book.isWishlisted);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<BookModel>> updateBookById(
      UpdateBookModel book) async {
    try {
      return await _dioClient.patch(
        '/books/${book.id}',
        data: book,
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<BookModel>> deleteBookById(String id) async {
    try {
      return await _dioClient.delete(
        '/books/$id',
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  // * Gabungin aja biarpun routesnya beda, nanti backend kapan kapan benerin
  Future<ApiSuccessResponse<void>> addBookToWishlist(String id) async {
    try {
      return await _dioClient.post(
        '/book-wishlist/$id',
        fromJsonT: (json) {},
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> getBooksInWishlist(
    BookFilterModel bookFilterModel,
  ) async {
    try {
      final queryParameters = {
        'page': bookFilterModel.page,
        'limit': bookFilterModel.limit,
      };

      return await _dioClient.get(
        '/book-wishlist',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List).map((item) {
          final book = BookModel.fromJson(item as Map<String, dynamic>);
          return book.copyWith(originalWishlistStatus: book.isWishlisted);
        }).toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<void>> removeBookFromWishlist(String id) async {
    try {
      return await _dioClient.delete(
        '/book-wishlist/$id',
        fromJsonT: (json) {},
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
