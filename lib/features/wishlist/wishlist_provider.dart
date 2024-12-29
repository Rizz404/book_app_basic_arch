import 'dart:async';

import 'package:book_app_basic_arch/core/shared/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/wishlist/model/wishlist_filter_model.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_services.dart';
import 'package:book_app_basic_arch/features/wishlist/enum_wishlist_operation.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistServices _wishlistServices;
  final BookProvider bookProvider;

  // Antrian operasi wishlist yang pending
  final Map<String, bool> _pendingOperations = {};
  // Map untuk menyimpan timer per bookId
  final Map<String, Timer> _debouncers = {};
  // Durasi debounce
  static const debounceDuration = Duration(milliseconds: 500);

  WishlistProvider({
    required this.bookProvider,
    WishlistServices? wishlistServices,
  }) : _wishlistServices = wishlistServices ?? WishlistServices();

  void _cancelDebouncer(String bookId) {
    _debouncers[bookId]?.cancel();
    _debouncers.remove(bookId);
  }

  // * State untuk menyimpan books per screen
  final Map<String, List<BookModel>> _screenBooks = {};
  // * State untuk menyimpan pagination per screen
  final Map<String, ApiPagination?> _screenPaginations = {};

  // * State untuk menyimpan filter tiap screen
  final Map<String, WishlistFilterModel> _screenFilters = {
    'wishlist': WishlistFilterModel(),
  };

  // * Getter untuk books berdasarkan screen
  List<BookModel> getBooksForScreen(String screenName) {
    return _screenBooks[screenName] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForScreen(String screenName) {
    return _screenPaginations[screenName];
  }

  // * Getter untuk filter berdasarkan screen
  WishlistFilterModel getScreenFilter(String screenName) {
    return _screenFilters[screenName] ?? WishlistFilterModel();
  }

  // * Method untuk update filter
  void updateScreenFilter(String screenName, WishlistFilterModel newFilter) {
    _screenFilters[screenName] = newFilter;
    notifyListeners();
  }

  final Map<EnumWishlistOperation, OperationState> _operationStates = {
    for (var operation in EnumWishlistOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  bool isLoading(EnumWishlistOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumWishlistOperation operation) =>
      _operationStates[operation]!.errorMessage;

  void _updateOperationState(EnumWishlistOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createWishlist(String bookId) async {
    // * Optimistic update
    bookProvider.updateBookWishlistStatus(bookId, true);

    _updateOperationState(
      EnumWishlistOperation.create,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _wishlistServices.createWishlist(bookId);

      // * Sukses, update screen wishlist
      await getBooksWishlished();

      _updateOperationState(
        EnumWishlistOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // * Rollback jika gagal
      bookProvider.rollbackBookWishlistStatus(bookId);

      _updateOperationState(
        EnumWishlistOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error creating wishlist: $e');
    }
  }

  Future<void> getBooksWishlished({String screenName = 'wishlist'}) async {
    final filter = _screenFilters[screenName]!;

    _updateOperationState(
      EnumWishlistOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _wishlistServices.getBooksWishlished(
        page: filter.page,
        limit: filter.limit,
      );

      _screenBooks[screenName] = response.data!;
      _screenPaginations[screenName] = response.meta.pagination;

      _updateOperationState(
        EnumWishlistOperation.getAll,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumWishlistOperation.getAll,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> deleteWishlist(String id) async {
    // * Optimistic update
    bookProvider.updateBookWishlistStatus(id, false);

    _updateOperationState(
      EnumWishlistOperation.delete,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _wishlistServices.deleteWishlistById(id);

      // * Sukses, update screen wishlist
      await getBooksWishlished();

      _updateOperationState(
        EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // * Rollback jika gagal
      bookProvider.rollbackBookWishlistStatus(id);

      _updateOperationState(
        EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error deleting wishlist: $e');
    }
  }

  // Method untuk memproses operasi wishlist
  Future<void> _processWishlistOperation(
      String bookId, bool targetStatus) async {
    try {
      if (targetStatus) {
        await _wishlistServices.createWishlist(bookId);
      } else {
        await _wishlistServices.deleteWishlistById(bookId);
      }

      // Update originalWishlistStatus jika berhasil
      bookProvider.updateBookWishlistStatus(bookId, targetStatus);

      _updateOperationState(
        targetStatus
            ? EnumWishlistOperation.create
            : EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // Rollback jika gagal
      bookProvider.rollbackBookWishlistStatus(bookId);

      // Rollback WishlistProvider state
      if (targetStatus) {
        // Jika gagal menambah wishlist, hapus dari _screenBooks
        for (var screenName in _screenBooks.keys) {
          _screenBooks[screenName] =
              _screenBooks[screenName]!.where((b) => b.id != bookId).toList();
        }
      } else {
        // Jika gagal menghapus wishlist, tambahkan kembali ke _screenBooks
        final book = _findBookInAnyScreen(bookId);
        if (book != null) {
          for (var screenName in _screenBooks.keys) {
            if (!_screenBooks[screenName]!.any((b) => b.id == bookId)) {
              _screenBooks[screenName] = [
                book.copyWith(
                  isWishlisted: true,
                  wishlistCount: book.wishlistCount,
                  originalWishlistStatus: true,
                ),
                ..._screenBooks[screenName]!,
              ];
            }
          }
        }
      }
      notifyListeners();

      _updateOperationState(
        targetStatus
            ? EnumWishlistOperation.create
            : EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error processing wishlist operation: $e');
    }
  }

  // Helper method untuk mencari buku di semua screen
  BookModel? _findBookInAnyScreen(String bookId) {
    for (var books in _screenBooks.values) {
      final book = books.firstWhere(
        (b) => b.id == bookId,
      );
      return book;
    }
    return null;
  }

  Future<void> toggleWishlist(BookModel book) async {
    final targetStatus = !book.isWishlisted;

    // Batalkan timer sebelumnya jika ada
    _cancelDebouncer(book.id);

    // Update UI secara optimistic untuk BookProvider
    bookProvider.updateBookWishlistStatus(book.id, targetStatus);

    // Optimistic update untuk WishlistProvider
    if (targetStatus) {
      // Jika menambah ke wishlist
      for (var screenName in _screenBooks.keys) {
        if (!_screenBooks[screenName]!.any((b) => b.id == book.id)) {
          _screenBooks[screenName] = [
            book.copyWith(
              isWishlisted: true,
              wishlistCount: book.wishlistCount + 1,
              originalWishlistStatus: true,
            ),
            ..._screenBooks[screenName]!,
          ];
        }
      }
    } else {
      // Jika menghapus dari wishlist
      for (var screenName in _screenBooks.keys) {
        _screenBooks[screenName] =
            _screenBooks[screenName]!.where((b) => b.id != book.id).toList();
      }
    }
    notifyListeners();

    // Tambahkan ke antrian operasi
    _pendingOperations[book.id] = targetStatus;

    // Set timer baru untuk debounce
    _debouncers[book.id] = Timer(debounceDuration, () async {
      // Pastikan operasi masih valid
      if (_pendingOperations.containsKey(book.id) &&
          _pendingOperations[book.id] == targetStatus) {
        _updateOperationState(
          targetStatus
              ? EnumWishlistOperation.create
              : EnumWishlistOperation.delete,
          isLoading: true,
          errorMessage: null,
        );

        await _processWishlistOperation(book.id, targetStatus);

        // Hapus dari antrian setelah selesai
        _pendingOperations.remove(book.id);
      }
    });
  }

  @override
  void dispose() {
    // Batalkan semua timer saat dispose
    for (var timer in _debouncers.values) {
      timer.cancel();
    }
    _debouncers.clear();
    _pendingOperations.clear();
    super.dispose();
  }
}
