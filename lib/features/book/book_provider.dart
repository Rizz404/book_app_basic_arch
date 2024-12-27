import 'package:book_app_basic_arch/core/shared/provider/operation_state_handler.dart';
import 'package:book_app_basic_arch/features/book/book_services.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  final BookServices _bookServices = BookServices();
  final OperationStateHandler<EnumBookOperation> _stateHandler =
      OperationStateHandler<EnumBookOperation>();

  List<BookModel> _books = [];
  List<BookModel> get books => _books;
  BookModel? _book;
  BookModel? get book => _book;

  // * Proxy untuk state
  bool isLoading(EnumBookOperation operation) =>
      _stateHandler.isLoading(operation);

  String? getError(EnumBookOperation operation) =>
      _stateHandler.getError(operation);

  Future<void> createBook(CreateBookModel book) async {
    _stateHandler.updateState(
      EnumBookOperation.create,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _bookServices.createBook(book);
      await getBooks();

      _stateHandler.updateState(
        EnumBookOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _stateHandler.updateState(
        EnumBookOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBooks() async {
    _stateHandler.updateState(
      EnumBookOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks();

      _books = response.data!;

      _stateHandler.updateState(
        EnumBookOperation.getAll,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _stateHandler.updateState(
        EnumBookOperation.getAll,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBookById(String id) async {
    _stateHandler.updateState(
      EnumBookOperation.getById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBookById(id);

      _book = response.data!;

      _stateHandler.updateState(
        EnumBookOperation.getById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _stateHandler.updateState(
        EnumBookOperation.getById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> updateBook(UpdateBookModel book) async {
    _stateHandler.updateState(
      EnumBookOperation.update,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.updateBookById(book);
      await getBookById(book.id);
      await getBooks();

      _stateHandler.updateState(
        EnumBookOperation.update,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _stateHandler.updateState(
        EnumBookOperation.update,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }

  Future<void> deleteBook(String id) async {
    _stateHandler.updateState(
      EnumBookOperation.delete,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.deleteBookById(id);
      await getBooks();

      _stateHandler.updateState(
        EnumBookOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _stateHandler.updateState(
        EnumBookOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }
}
