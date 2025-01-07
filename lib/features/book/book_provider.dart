import 'dart:async';

import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/book_services.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/model/book_filter_model.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  final BookServices _bookServices = BookServices();

  // * State untuk menyimpan books per screen
  final Map<BookScreenType, List<BookModel>> _booksByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<BookScreenType, ApiPagination?> _paginationByScreen = {};

  // * Getter untuk hasil search (pake map yang sama)
  List<BookModel> get searchedBooks =>
      _booksByScreen[BookScreenType.search] ?? [];

  ApiPagination? get searchedBooksPagination =>
      _paginationByScreen[BookScreenType.search];

  // * Cache untuk book berdasarkan ID
  final Map<String, BookModel> _bookCache = {};

  // * Getter untuk single book dari cache
  BookModel? getBookByIdFromCache(String id) => _bookCache[id];

  // * State untuk menyimpan filter tiap screen
  final Map<BookScreenType, BookFilterModel> _filterByScreen = {
    BookScreenType.home: const BookFilterModel(),
    BookScreenType.books: const BookFilterModel(),
    BookScreenType.wishlist: const BookFilterModel(),
    BookScreenType.bookDetail: const BookFilterModel(),
    BookScreenType.search: const BookFilterModel(),
    BookScreenType.genreDetail: const BookFilterModel(),
    BookScreenType.authorDetail: const BookFilterModel(),
    BookScreenType.publisherDetail: const BookFilterModel(),
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
    return _filterByScreen[screen] ?? const BookFilterModel();
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
    BookScreenType screen = BookScreenType.books,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      BookOperationType.getBooks,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooks(filter);

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

  Future<void> getBookById(String id) async {
    // * Cek cache terlebih dahulu
    if (_bookCache.containsKey(id)) {
      return; // * Tidak perlu fetch jika sudah ada di cache dan refresh false
    }

    _updateOperationState(
      BookOperationType.getBookById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBookById(id);

      _bookCache[id] = response.data!;

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

  Future<void> searchBooksByTitle({
    required String title,
  }) async {
    // * Reset filter search ke page 1 dengan query baru
    final newFilter = BookFilterModel(
      page: 1,
      searchQuery: title,
    );
    _filterByScreen[BookScreenType.search] = newFilter;

    _updateOperationState(
      BookOperationType.searchBooks,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.searchBooksByTitle(title: title);

      _booksByScreen[BookScreenType.search] = response.data!;
      _paginationByScreen[BookScreenType.search] = response.meta.pagination;

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
      debugPrint('Error searching books: $e');
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

  // * Beda routes tapi disatuin aja
  Future<void> addBookToWishlist(String id) async {
    _updateOperationState(
      BookOperationType.addBookToWishlist,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _bookServices.addBookToWishlist(id);

      _updateOperationState(
        BookOperationType.addBookToWishlist,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.addBookToWishlist,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error follow book: $e');
    }
  }

  Future<void> getBooksInWishlist({
    BookScreenType screen = BookScreenType.wishlist,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      BookOperationType.getBooksInWishlist,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _bookServices.getBooksInWishlist(filter);

      _booksByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        BookOperationType.getBooksInWishlist,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.getBooksInWishlist,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books followed: $e');
    }
  }

  Future<void> removeBookFromWishlist(String id) async {
    _updateOperationState(
      BookOperationType.removeBookFromWishlist,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _bookServices.removeBookFromWishlist(id);

      // Tambahkan ini: Update wishlist screen setelah remove
      if (_booksByScreen.containsKey(BookScreenType.wishlist)) {
        _booksByScreen[BookScreenType.wishlist] =
            _booksByScreen[BookScreenType.wishlist]!
                .where((book) => book.id != id)
                .toList();
      }

      _updateOperationState(
        BookOperationType.removeBookFromWishlist,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        BookOperationType.removeBookFromWishlist,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error follow book: $e');
    }
  }

  // * Method generic untuk load more data
  Future<void> loadMoreBooks(BookScreenType screen) async {
    final currentFilter = _filterByScreen[screen]!;
    final currentPagination = _paginationByScreen[screen];

    // * Cek apakah masih ada halaman selanjutnya
    if (currentPagination != null &&
        currentPagination.currentPage >= currentPagination.totalPages) {
      return;
    }

    // * Update filter dengan page selanjutnya
    final newFilter = currentFilter.copyWith(
      page: (currentPagination?.currentPage ?? 0) + 1,
    );
    _filterByScreen[screen] = newFilter;

    // * Tentukan operation type berdasarkan screen
    final operationType = _getOperationTypeForScreen(screen);

    _updateOperationState(
      operationType,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _getDataForScreen(screen, newFilter);

      // * Tambahkan data baru ke list yang sudah ada
      _booksByScreen[screen] = [
        ...(_booksByScreen[screen] ?? []),
        ...response.data!
      ];
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        operationType,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        operationType,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error loading more data: $e');
    }
  }

  // * *============*function yang gak langsung fetch api*============*
  // * Helper method untuk mendapatkan operation type berdasarkan screen
  BookOperationType _getOperationTypeForScreen(BookScreenType screen) {
    switch (screen) {
      case BookScreenType.home:
        return BookOperationType.getBooks;
      case BookScreenType.books:
        return BookOperationType.getBooks;
      case BookScreenType.wishlist:
        return BookOperationType.getBooksInWishlist;
      case BookScreenType.search:
        return BookOperationType.searchBooks;
      case BookScreenType.bookDetail:
        return BookOperationType.getBooks;
      case BookScreenType.genreDetail:
        return BookOperationType.getBooks;
      case BookScreenType.publisherDetail:
        return BookOperationType.getBooks;
      case BookScreenType.authorDetail:
        return BookOperationType.getBooks;
    }
  }

  // * Helper method untuk mendapatkan data berdasarkan screen
  Future<ApiSuccessResponse<List<BookModel>>> _getDataForScreen(
    BookScreenType screen,
    BookFilterModel filter,
  ) async {
    switch (screen) {
      case BookScreenType.home:
        return await _bookServices.getBooks(filter);
      case BookScreenType.books:
        return await _bookServices.getBooks(filter);
      case BookScreenType.wishlist:
        return await _bookServices.getBooksInWishlist(filter);
      case BookScreenType.search:
        // * Asumsikan ada searchQuery yang disimpan
        final searchQuery = filter.searchQuery;
        if (searchQuery == null) {
          throw Exception('Search query is required for search screen');
        }
        return await _bookServices.searchBooksByTitle(title: searchQuery);
      case BookScreenType.genreDetail:
        return await _bookServices.getBooks(filter);
      case BookScreenType.bookDetail:
        return await _bookServices.getBooks(filter);
      case BookScreenType.publisherDetail:
        return await _bookServices.getBooks(filter);
      case BookScreenType.authorDetail:
        return await _bookServices.getBooks(filter);
    }
  }

  void resetSearch() {
    _booksByScreen[BookScreenType.search] = [];
    _paginationByScreen[BookScreenType.search] = null;
    notifyListeners();
  }

  // * Optimistik update
  // * Map untuk menyimpan timer debounce per book
  final Map<String, Timer> _followDebounceTimers = {};
  // * Duration untuk debounce
  static const _debounceDuration = Duration(milliseconds: 500);

  // * Method untuk update status follow secara optimistic
  void updateBookWishlistStatus(String bookId, bool isWishlisted) {
    // * Update di semua screen yang menyimpan book
    _booksByScreen.forEach((screen, books) {
      final bookIndex = books.indexWhere((book) => book.id == bookId);
      if (bookIndex != -1) {
        final updatedBooks = List<BookModel>.from(books);
        updatedBooks[bookIndex] = books[bookIndex].copyWith(
          isWishlisted: isWishlisted,
          wishlistCount: isWishlisted
              ? books[bookIndex].wishlistCount + 1
              : books[bookIndex].wishlistCount - 1,
        );
        _booksByScreen[screen] = updatedBooks;
      }
    });

    // * Update untuk single book detail
    if (_bookCache[bookId]?.id == bookId) {
      _bookCache[bookId] = _bookCache[bookId]!.copyWith(
        isWishlisted: isWishlisted,
        wishlistCount: isWishlisted
            ? _bookCache[bookId]!.wishlistCount + 1
            : _bookCache[bookId]!.wishlistCount - 1,
      );
    }

    notifyListeners();
  }

  // * Method untuk rollback status follow
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

    // * Rollback untuk single book detail
    if (_bookCache[bookId]?.id == bookId) {
      _bookCache[bookId] = _bookCache[bookId]!.copyWith(
        isWishlisted: _bookCache[bookId]!.originalWishlistStatus,
        wishlistCount: _bookCache[bookId]!.originalWishlistStatus
            ? _bookCache[bookId]!.wishlistCount + 1
            : _bookCache[bookId]!.wishlistCount - 1,
      );
    }

    notifyListeners();
  }

  Future<void> toggleWishlist(String bookId) async {
    // * Cari book di semua screen
    BookModel? targetBook;

    // Cek di _bookCache[bookId] dulu
    if (_bookCache[bookId]?.id == bookId) {
      targetBook = _bookCache[bookId];
    } else {
      // Kalau tidak ketemu di _bookCache[bookId], cari di _booksByScreen
      for (var books in _booksByScreen.values) {
        final foundBook = books.where((book) => book.id == bookId).firstOrNull;
        if (foundBook != null) {
          targetBook = foundBook;
          break;
        }
      }
    }

    // Kalau book tidak ditemukan dimana-mana, return
    if (targetBook == null) return;

    // * Cancel timer yang sedang berjalan (jika ada)
    _followDebounceTimers[bookId]?.cancel();

    // * Update UI secara optimistic
    final newWishlistStatus = !targetBook.isWishlisted;
    updateBookWishlistStatus(bookId, newWishlistStatus);

    // * Set timer baru untuk debounce
    _followDebounceTimers[bookId] = Timer(_debounceDuration, () async {
      // * Cek apakah status berubah dari original
      final currentBook = _findBookById(bookId);
      if (currentBook == null) return;

      if (currentBook.isWishlisted != currentBook.originalWishlistStatus) {
        try {
          if (currentBook.isWishlisted) {
            await addBookToWishlist(bookId);
            await getBooksInWishlist(); // Refresh wishlist
          } else {
            await removeBookFromWishlist(bookId);
          }

          // * Update original status setelah berhasil
          _updateOriginalWishlistStatus(bookId, currentBook.isWishlisted);
        } catch (e) {
          // * Rollback jika gagal
          rollbackBookWishlistStatus(bookId);
          debugPrint('Error toggling follow status: $e');
        }
      }
    });
  }

  // * Helper method untuk mencari book di semua screen
  BookModel? _findBookById(String bookId) {
    for (var books in _booksByScreen.values) {
      final book = books.where((book) => book.id == bookId).firstOrNull;
      if (book != null) return book;
    }
    return _bookCache[bookId]?.id == bookId ? _bookCache[bookId] : null;
  }

  // * Helper method untuk update original follow status
  void _updateOriginalWishlistStatus(String bookId, bool newStatus) {
    _booksByScreen.forEach((screen, books) {
      final bookIndex = books.indexWhere((book) => book.id == bookId);
      if (bookIndex != -1) {
        final updatedBooks = List<BookModel>.from(books);
        updatedBooks[bookIndex] = books[bookIndex].copyWith(
          originalWishlistStatus: newStatus,
        );
        _booksByScreen[screen] = updatedBooks;
      }
    });

    if (_bookCache[bookId]?.id == bookId) {
      _bookCache[bookId] =
          _bookCache[bookId]!.copyWith(originalWishlistStatus: newStatus);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // * Cancel semua timer saat dispose
    for (var timer in _followDebounceTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}
