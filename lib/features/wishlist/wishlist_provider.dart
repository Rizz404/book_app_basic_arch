import 'package:book_app_basic_arch/core/shared/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:book_app_basic_arch/features/wishlist/wishlist_services.dart';
import 'package:book_app_basic_arch/features/wishlist/enum_wishlist_operation.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistServices _wishlistServices = WishlistServices();

  List<BookModel> _books = [];
  List<BookModel> get books => _books;
  ApiPagination? _pagination;
  ApiPagination? get pagination => _pagination;

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
    _updateOperationState(
      EnumWishlistOperation.create,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _wishlistServices.createWishlist(bookId);

      _updateOperationState(
        EnumWishlistOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumWishlistOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> getBooksWishlished({
    int page = 1,
    int limit = 10,
  }) async {
    _updateOperationState(
      EnumWishlistOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _wishlistServices.getBooksWishlished();

      _books = response.data!;
      _pagination = response.meta.pagination;

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
    _updateOperationState(
      EnumWishlistOperation.delete,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _wishlistServices.deleteWishlistById(id);

      _updateOperationState(
        EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumWishlistOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating wishlist: $e');
    }
  }
}
