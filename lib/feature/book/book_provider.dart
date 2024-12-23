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
    _updateOperationState(EnumBookOperation.create, isLoading: true);
    notifyListeners();
    try {
      await _bookServices.createBook(book);

      await getBooks();
    } catch (e) {
      _updateOperationState(EnumBookOperation.create,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching books: $e');
    } finally {
      _updateOperationState(EnumBookOperation.create, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getBooks() async {
    _updateOperationState(EnumBookOperation.getAll, isLoading: true);
    notifyListeners();
    try {
      final response = await _bookServices.getBooks();

      _books = response.data!;
    } catch (e) {
      _updateOperationState(EnumBookOperation.getAll,
          errorMessage: 'Error fetching genres: $e');
      debugPrint('Error fetching books: $e');
    } finally {
      _updateOperationState(EnumBookOperation.getAll, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getBookById(String id) async {
    _updateOperationState(EnumBookOperation.getById, isLoading: true);
    notifyListeners();
    try {
      final response = await _bookServices.getBookById(id);

      _book = response.data!;
    } catch (e) {
      _updateOperationState(EnumBookOperation.getById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching books: $e');
    } finally {
      _updateOperationState(EnumBookOperation.getById, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updateBook(UpdateBookModel book) async {
    _updateOperationState(EnumBookOperation.update, isLoading: true);
    notifyListeners();

    try {
      await _bookServices.updateBookById(book);

      await getBookById(book.id);
      await getBooks();
    } catch (e) {
      _updateOperationState(EnumBookOperation.update,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating book: $e');
    } finally {
      _updateOperationState(EnumBookOperation.update, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    _updateOperationState(EnumBookOperation.delete, isLoading: true);
    notifyListeners();

    try {
      await _bookServices.deleteBookById(id);
      await getBooks();
    } catch (e) {
      _updateOperationState(EnumBookOperation.delete,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating book: $e');
    } finally {
      _updateOperationState(EnumBookOperation.delete, isLoading: false);
      notifyListeners();
    }
  }
}
