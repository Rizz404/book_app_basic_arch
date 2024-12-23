import 'package:book_app_basic_arch/core/network/dio_client.dart';
import 'package:book_app_basic_arch/core/shared/models/api_success_response.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:dio/dio.dart';

class BookServices {
  final DioClient _dioClient = DioClient();

  Future<ApiSuccessResponse<BookModel>> createBook(CreateBookModel book) async {
    try {
      return await _dioClient.post(
        '/books',
        data: book,
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<List<BookModel>>> getBooks() async {
    try {
      return await _dioClient.get(
        '/books',
        fromJsonT: (json) => (json as List)
            .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<BookModel>> getBookById(String id) async {
    try {
      return await _dioClient.get(
        '/books/$id',
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
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
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }

  Future<ApiSuccessResponse<BookModel>> deleteBookById(String id) async {
    try {
      return await _dioClient.delete(
        '/books/$id',
        fromJsonT: (json) => BookModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data['message'] ?? "An unknown error occurred";
    }
  }
}
