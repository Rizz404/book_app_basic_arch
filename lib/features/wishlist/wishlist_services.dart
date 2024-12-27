import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/wishlist/model/wishlist_model.dart';
import 'package:book_app_basic_arch/core/shared/models/api_error_response.dart';

class WishlistServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse> createWishlist(
    String bookId,
  ) async {
    try {
      return await _dioClient.post(
        '/book-wishlist/$bookId',
        fromJsonT: (json) =>
            WishlistModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> getBooksWishlished({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
      };

      return await _dioClient.get(
        '/book-wishlist',
        queryParameters: queryParameters,
        fromJsonT: (json) => (json as List)
            .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }

  Future<ApiSuccessResponse<WishlistModel>> deleteWishlistById(
    String bookId,
  ) async {
    try {
      return await _dioClient.delete(
        '/book-wishlist/$bookId',
        fromJsonT: (json) =>
            WishlistModel.fromJson(json as Map<String, dynamic>),
      );
    } on ApiErrorResponse catch (e) {
      throw e.message;
    }
  }
}
