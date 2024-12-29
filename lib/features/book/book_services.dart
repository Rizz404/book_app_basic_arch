import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_error_response.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';

class BookServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<BookModel>> createBook(CreateBookModel book) async {
    try {
      return await _dioClient.post(
        '/books',
        data: book,
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>)
            .copyWith(
                originalWishlistStatus: BookModel.fromJson(json).isWishlisted),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> getBooks({
    int page = 1,
    int limit = 10,
    String? sellerId,
    String? language,
    String? genreId,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        if (sellerId != null) 'sellerId': sellerId,
        if (language != null) 'language': language,
        if (genreId != null) 'genreId': genreId,
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

  Future<ApiSuccessResponse<List<BookModel>>> searchBookByTitle({
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
        fromJsonT: (json) {
          final updatedBook = BookModel.fromJson(json as Map<String, dynamic>);
          return updatedBook.copyWith(
              originalWishlistStatus: updatedBook.isWishlisted);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<BookModel>> deleteBookById(String id) async {
    try {
      return await _dioClient.delete(
        '/books/$id',
        fromJsonT: (json) {
          final deletedBook = BookModel.fromJson(json as Map<String, dynamic>);
          return deletedBook.copyWith(
              originalWishlistStatus: deletedBook.isWishlisted);
        },
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
