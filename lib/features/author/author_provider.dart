import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/author/author_services.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/enums/author_screen_type.dart';
import 'package:book_app_basic_arch/features/author/model/author_filter_model.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';

class AuthorProvider with ChangeNotifier {
  final AuthorServices _authorServices = AuthorServices();

  // * State untuk menyimpan authors per screen
  final Map<AuthorScreenType, List<AuthorModel>> _authorsByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<AuthorScreenType, ApiPagination?> _paginationByScreen = {};

  // * Beda buat search
  List<AuthorModel> _searchedAuthors = [];
  List<AuthorModel> get searchedAuthors => _searchedAuthors;
  ApiPagination? _searchedAuthorsPagination;
  ApiPagination? get searchedAuthorsPagination => _searchedAuthorsPagination;

  // * State untuk single author detail
  AuthorModel? _author;
  AuthorModel? get author => _author;

  // * State untuk menyimpan filter tiap screen
  final Map<AuthorScreenType, AuthorFilterModel> _filterByScreen = {
    AuthorScreenType.authors: AuthorFilterModel(),
  };

  // * Getter untuk authors berdasarkan screen
  List<AuthorModel> getAuthorsForSpecificScreen(AuthorScreenType screen) {
    return _authorsByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(AuthorScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  AuthorFilterModel getFilterForSpecificScreen(AuthorScreenType screen) {
    return _filterByScreen[screen] ?? AuthorFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      AuthorScreenType screen, AuthorFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

  // * Map untuk store operation state
  final Map<AuthorOperationType, OperationState> _operationStates = {
    for (var operation in AuthorOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(AuthorOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(AuthorOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  void _updateOperationState(AuthorOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createAuthor(CreateAuthorModel author) async {
    _updateOperationState(
      AuthorOperationType.createAuthor,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.createAuthor(author);
      await getAuthors();

      _updateOperationState(
        AuthorOperationType.createAuthor,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.createAuthor,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> getAuthors({
    AuthorScreenType screen = AuthorScreenType.authors,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      AuthorOperationType.getAuthors,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthors(filter);

      _authorsByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        AuthorOperationType.getAuthors,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.getAuthors,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> getAuthorById(String id) async {
    _updateOperationState(
      AuthorOperationType.getAuthorById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthorById(id);

      _author = response.data!;

      _updateOperationState(
        AuthorOperationType.getAuthorById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.getAuthorById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> updateAuthor(UpdateAuthorModel author) async {
    _updateOperationState(
      AuthorOperationType.updateAuthorById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.updateAuthorById(author);

      await getAuthorById(author.id);
      await getAuthors();

      _updateOperationState(
        AuthorOperationType.updateAuthorById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.updateAuthorById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating author: $e');
    }
  }

  Future<void> deleteAuthor(String id) async {
    _updateOperationState(
      AuthorOperationType.deleteAuthorById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.deleteAuthorById(id);
      await getAuthors();

      _updateOperationState(
        AuthorOperationType.deleteAuthorById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.deleteAuthorById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating author: $e');
    }
  }
}
