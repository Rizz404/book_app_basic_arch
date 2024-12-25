import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/feature/book/book_services.dart';
import 'package:book_app_basic_arch/feature/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  final BookServices _bookServices = BookServices();

  List<BookModel> _books = [];
  List<BookModel> get books => _books;
  BookModel? _book;
  BookModel? get book => _book;

  // * Map untuk store operation state
  final Map<EnumBookOperation, OperationState> _operationStates = {
    for (var operation in EnumBookOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumBookOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumBookOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumBookOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createBook(CreateBookModel book) async {
    _updateOperationState(
      EnumBookOperation.create,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _bookServices.createBook(book);
      await getBooks();

      _updateOperationState(
        EnumBookOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBooks() async {
    _updateOperationState(
      EnumBookOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks();

      _books = response.data!;

      _updateOperationState(
        EnumBookOperation.getAll,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.getAll,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBookById(String id) async {
    _updateOperationState(
      EnumBookOperation.getById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBookById(id);

      _book = response.data!;

      _updateOperationState(
        EnumBookOperation.getById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.getById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> updateBook(UpdateBookModel book) async {
    _updateOperationState(
      EnumBookOperation.update,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.updateBookById(book);
      await getBookById(book.id);
      await getBooks();

      _updateOperationState(
        EnumBookOperation.update,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.update,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }

  Future<void> deleteBook(String id) async {
    _updateOperationState(
      EnumBookOperation.delete,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.deleteBookById(id);
      await getBooks();

      _updateOperationState(
        EnumBookOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }
}
