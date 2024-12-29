import 'package:book_app_basic_arch/core/shared/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/wishlist/model/wishlist_filter_model.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_services.dart';
import 'package:book_app_basic_arch/features/wishlist/enum_wishlist_operation.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistServices _wishlistServices = WishlistServices();
  final BookProvider bookProvider;

  WishlistProvider({required this.bookProvider});

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
}
