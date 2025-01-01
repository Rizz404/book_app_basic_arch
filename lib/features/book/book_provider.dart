import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/book_services.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/model/book_filter_model.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  final BookServices _bookServices = BookServices();

  // * State untuk menyimpan books per screen
  final Map<BookScreenType, List<BookModel>> _booksByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<BookScreenType, ApiPagination?> _paginationByScreen = {};

  // * Beda buat search
  List<BookModel> _searchedBooks = [];
  List<BookModel> get searchedBooks => _searchedBooks;
  ApiPagination? _searchedBooksPagination;
  ApiPagination? get searchedBooksPagination => _searchedBooksPagination;

  // * State untuk single book detail
  BookModel? _book;
  BookModel? get book => _book;

  // * State untuk menyimpan filter tiap screen
  final Map<BookScreenType, BookFilterModel> _filterByScreen = {
    BookScreenType.home: BookFilterModel(),
    BookScreenType.books: BookFilterModel(),
    BookScreenType.bookDetail: BookFilterModel(),
    BookScreenType.search: BookFilterModel(),
    BookScreenType.genreDetail: BookFilterModel(),
    BookScreenType.authorDetail: BookFilterModel(),
    BookScreenType.publisherDetail: BookFilterModel(),
  };

  // * Getter untuk books berdasarkan screen
  List<BookModel> getBooksForSpecificScreen(BookScreenType screen) {
    return _booksByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(BookScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  BookFilterModel getFilterForSpecificScreen(BookScreenType screen) {
    return _filterByScreen[screen] ?? BookFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      BookScreenType screen, BookFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

  // * Map untuk store operation state
  final Map<BookOperationType, OperationState> _operationStates = {
    for (var operation in BookOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(BookOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(BookOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  void _updateOperationState(BookOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createBook(CreateBookModel book) async {
    _updateOperationState(
      BookOperationType.createBook,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _bookServices.createBook(book);
      await getBooks();

      _updateOperationState(
        BookOperationType.createBook,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.createBook,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBooks({
    BookScreenType screen = BookScreenType.home,
    bool refresh = false,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      BookOperationType.getBooks,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks(
        filter,
        forceRefresh: refresh,
      );

      _booksByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        BookOperationType.getBooks,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.getBooks,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> searchBooksByTitle({
    int page = 1,
    int limit = 10,
    required String title,
    bool refresh = false,
  }) async {
    _updateOperationState(
      BookOperationType.searchBooks,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.searchBookByTitle(
        title: title,
        page: page,
        limit: limit,
        forceRefresh: refresh,
      );

      // * Jika ini adalah halaman pertama, ganti list
      // * Jika bukan, tambahkan ke list yang sudah ada
      if (page == 1) {
        _searchedBooks = response.data!;
      } else {
        _searchedBooks = [..._searchedBooks, ...response.data!];
      }
      _searchedBooksPagination = response.meta.pagination;

      _updateOperationState(
        BookOperationType.searchBooks,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.searchBooks,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  void resetSearch() {
    _searchedBooks = [];
    notifyListeners();
  }

  Future<void> getBookById(
    String id, {
    bool refresh = false,
  }) async {
    _updateOperationState(
      BookOperationType.getBookById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBookById(
        id,
        forceRefresh: refresh,
      );

      _book = response.data!;

      _updateOperationState(
        BookOperationType.getBookById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.getBookById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> updateBook(UpdateBookModel book) async {
    _updateOperationState(
      BookOperationType.updateBookById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.updateBookById(book);
      await getBookById(book.id);
      await getBooks();

      _updateOperationState(
        BookOperationType.updateBookById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.updateBookById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }

  Future<void> deleteBook(String id) async {
    _updateOperationState(
      BookOperationType.deleteBookById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _bookServices.deleteBookById(id);
      await getBooks();

      _updateOperationState(
        BookOperationType.deleteBookById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.deleteBookById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating book: $e');
    }
  }

  // * Buat infinite scroll
  Future<void> loadMoreBooks(
      {BookScreenType screen = BookScreenType.home}) async {
    final currentFilter = _filterByScreen[screen]!;
    final currentPagination = _paginationByScreen[screen];

    // * Cek apakah masih ada halaman selanjutnya
    if (currentPagination != null &&
        currentPagination.currentPage >= currentPagination.totalPages) {
      return;
    }

    // * Buat filter baru dengan page yang diupdate
    final newFilter =
        currentFilter.copyWith(page: (currentPagination?.currentPage ?? 0) + 1);
    _filterByScreen[screen] = newFilter;

    _updateOperationState(
      BookOperationType.getBooks,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks(newFilter);

      // * Tambahkan data baru ke list yang sudah ada
      _booksByScreen[screen] = [
        ...(_booksByScreen[screen] ?? []),
        ...response.data!
      ];
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        BookOperationType.getBooks,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.getBooks,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error loading more books: $e');
    }
  }

  Future<void> loadMoreSearchedBooks(String title) async {
    // * Cek apakah masih ada halaman selanjutnya
    if (_searchedBooksPagination != null &&
        _searchedBooksPagination!.currentPage >=
            _searchedBooksPagination!.totalPages) {
      return;
    }

    // * Ambil halaman berikutnya
    await searchBooksByTitle(
      title: title,
      page: (_searchedBooksPagination?.currentPage ?? 0) + 1,
      limit: _filterByScreen[BookScreenType.search]!.limit,
    );
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
