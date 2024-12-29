import 'package:book_app_basic_arch/core/helpers/enum_screen_type.dart';
import 'package:book_app_basic_arch/core/shared/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/book_services.dart';
import 'package:book_app_basic_arch/features/book/enum_book_operation.dart';
import 'package:book_app_basic_arch/features/book/model/book_filter_model.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  final BookServices _bookServices = BookServices();

  // * State untuk menyimpan books per screen
  final Map<ScreenType, List<BookModel>> _booksByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<ScreenType, ApiPagination?> _paginationByScreen = {};

  // * Beda buat search
  List<BookModel> _searchedBooks = [];
  List<BookModel> get searchedBooks => _searchedBooks;
  ApiPagination? _searchedBooksPagination;
  ApiPagination? get searchedBooksPagination => _searchedBooksPagination;

  // * State untuk single book detail
  BookModel? _book;
  BookModel? get book => _book;

  // * State untuk menyimpan filter tiap screen
  final Map<ScreenType, BookFilterModel> _filterByScreen = {
    ScreenType.home: BookFilterModel(),
    ScreenType.books: BookFilterModel(),
    ScreenType.search: BookFilterModel(),
    ScreenType.genreDetail: BookFilterModel(),
    ScreenType.authorDetail: BookFilterModel(),
    ScreenType.publisherDetail: BookFilterModel(),
  };

  // * Getter untuk books berdasarkan screen
  List<BookModel> getBooksForSpecificScreen(ScreenType screen) {
    return _booksByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(ScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  BookFilterModel getFilterForSpecificScreen(ScreenType screen) {
    return _filterByScreen[screen] ?? BookFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      ScreenType screen, BookFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

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

  Future<void> getBooks({ScreenType screen = ScreenType.home}) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      EnumBookOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks(
        page: filter.page,
        limit: filter.limit,
        sellerId: filter.sellerId,
        language: filter.language,
        genreId: filter.genreId,
      );

      _booksByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

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

  Future<void> searchBookByTitle({
    int page = 1,
    int limit = 10,
    required String title,
  }) async {
    _updateOperationState(
      EnumBookOperation.search,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.searchBookByTitle(
        title: title,
      );

      _searchedBooks = response.data!;
      _searchedBooksPagination = response.meta.pagination;

      _updateOperationState(
        EnumBookOperation.search,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumBookOperation.search,
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

  void updateBookWishlistStatus(String bookId, bool isWishlisted) {
    // Update di semua screen yang menyimpan buku
    _booksByScreen.forEach((screen, books) {
      final bookIndex = books.indexWhere((book) => book.id == bookId);
      if (bookIndex != -1) {
        final updatedBooks = List<BookModel>.from(books);
        updatedBooks[bookIndex] = books[bookIndex].copyWith(
          isWishlisted: isWishlisted,
          wishlistCount: isWishlisted
              ? books[bookIndex].wishlistCount + 1
              : books[bookIndex].wishlistCount - 1,
          // Simpan status original yang baru
          originalWishlistStatus: isWishlisted,
        );
        _booksByScreen[screen] = updatedBooks;
      }
    });

    // Update untuk searched books
    final searchedBookIndex =
        _searchedBooks.indexWhere((book) => book.id == bookId);
    if (searchedBookIndex != -1) {
      final updatedSearchedBooks = List<BookModel>.from(_searchedBooks);
      updatedSearchedBooks[searchedBookIndex] =
          _searchedBooks[searchedBookIndex].copyWith(
        isWishlisted: isWishlisted,
        wishlistCount: isWishlisted
            ? _searchedBooks[searchedBookIndex].wishlistCount + 1
            : _searchedBooks[searchedBookIndex].wishlistCount - 1,
        originalWishlistStatus: isWishlisted,
      );
      _searchedBooks = updatedSearchedBooks;
    }

    // Update untuk single book detail
    if (_book?.id == bookId) {
      _book = _book!.copyWith(
        isWishlisted: isWishlisted,
        wishlistCount:
            isWishlisted ? _book!.wishlistCount + 1 : _book!.wishlistCount - 1,
        originalWishlistStatus: isWishlisted,
      );
    }

    notifyListeners();
  }

  void rollbackBookWishlistStatus(String bookId) {
    // * Rollback di semua screen
    _booksByScreen.forEach((screen, books) {
      final bookIndex = books.indexWhere((book) => book.id == bookId);
      if (bookIndex != -1) {
        final updatedBooks = List<BookModel>.from(books);
        updatedBooks[bookIndex] = books[bookIndex].copyWith(
          isWishlisted: books[bookIndex].originalWishlistStatus,
          wishlistCount: books[bookIndex].originalWishlistStatus
              ? books[bookIndex].wishlistCount + 1
              : books[bookIndex].wishlistCount - 1,
        );
        _booksByScreen[screen] = updatedBooks;
      }
    });

    // * Rollback untuk searched books
    final searchedBookIndex =
        _searchedBooks.indexWhere((book) => book.id == bookId);
    if (searchedBookIndex != -1) {
      final updatedSearchedBooks = List<BookModel>.from(_searchedBooks);
      updatedSearchedBooks[searchedBookIndex] =
          _searchedBooks[searchedBookIndex].copyWith(
        isWishlisted: _searchedBooks[searchedBookIndex].originalWishlistStatus,
        wishlistCount: _searchedBooks[searchedBookIndex].originalWishlistStatus
            ? _searchedBooks[searchedBookIndex].wishlistCount + 1
            : _searchedBooks[searchedBookIndex].wishlistCount - 1,
      );
      _searchedBooks = updatedSearchedBooks;
    }

    // Rollback untuk single book detail
    if (_book?.id == bookId) {
      _book = _book!.copyWith(
        isWishlisted: _book!.originalWishlistStatus,
        wishlistCount: _book!.originalWishlistStatus
            ? _book!.wishlistCount + 1
            : _book!.wishlistCount - 1,
      );
    }

    notifyListeners();
  }
}
