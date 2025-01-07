import 'dart:async';

import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
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

  // * Getter untuk hasil search (pake map yang sama)
  List<AuthorModel> get searchedAuthors =>
      _authorsByScreen[AuthorScreenType.search] ?? [];

  ApiPagination? get searchedAuthorsPagination =>
      _paginationByScreen[AuthorScreenType.search];

  // * Cache untuk author berdasarkan ID
  final Map<String, AuthorModel> _authorCache = {};

  // * Getter untuk single author dari cache
  AuthorModel? getAuthorByIdFromCache(String id) => _authorCache[id];

  // * State untuk menyimpan filter tiap screen
  final Map<AuthorScreenType, AuthorFilterModel> _filterByScreen = {
    AuthorScreenType.authors: const AuthorFilterModel(),
    AuthorScreenType.authorDetail: const AuthorFilterModel(),
    AuthorScreenType.authorsFollowed: const AuthorFilterModel(),
    AuthorScreenType.search: const AuthorFilterModel(),
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
    return _filterByScreen[screen] ?? const AuthorFilterModel();
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
    // * Cek cache terlebih dahulu
    if (_authorCache.containsKey(id)) {
      return; // * Tidak perlu fetch jika sudah ada di cache dan refresh false
    }

    _updateOperationState(
      AuthorOperationType.getAuthorById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthorById(id);

      _authorCache[id] = response.data!;

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

  Future<void> searchAuthorsByName({
    required String name,
  }) async {
    // * Reset filter search ke page 1 dengan query baru
    final newFilter = AuthorFilterModel(
      page: 1,
      searchQuery: name,
    );
    _filterByScreen[AuthorScreenType.search] = newFilter;

    _updateOperationState(
      AuthorOperationType.searchAuthors,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.searchAuthorsByName(name: name);

      _authorsByScreen[AuthorScreenType.search] = response.data!;
      _paginationByScreen[AuthorScreenType.search] = response.meta.pagination;

      _updateOperationState(
        AuthorOperationType.searchAuthors,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.searchAuthors,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error searching authors: $e');
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

  // * Beda routes tapi disatuin aja
  Future<void> followAuthorById(String id) async {
    _updateOperationState(
      AuthorOperationType.followAuthorById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _authorServices.followAuthorById(id);

      _updateOperationState(
        AuthorOperationType.followAuthorById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.followAuthorById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error follow author: $e');
    }
  }

  Future<void> getAuthorsFollowed({
    AuthorScreenType screen = AuthorScreenType.authorsFollowed,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      AuthorOperationType.getAuthorsFollowed,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthorsFollowed(filter);

      _authorsByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        AuthorOperationType.getAuthorsFollowed,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.getAuthorsFollowed,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors followed: $e');
    }
  }

  Future<void> unfollowAuthorById(String id) async {
    _updateOperationState(
      AuthorOperationType.unfollowAuthorById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _authorServices.unfollowAuthorById(id);

      _updateOperationState(
        AuthorOperationType.unfollowAuthorById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthorOperationType.unfollowAuthorById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error follow author: $e');
    }
  }

  // * Method generic untuk load more data
  bool canLoadMore(AuthorScreenType screen) {
    final pagination = _paginationByScreen[screen];
    return pagination?.hasNextPage ?? false;
  }

  Future<void> loadMoreAuthors(AuthorScreenType screen) async {
    final currentFilter = _filterByScreen[screen]!;
    final pagination = _paginationByScreen[screen];

    if (isLoading(_getOperationTypeForScreen(screen)) ||
        pagination == null ||
        !pagination.hasNextPage ||
        pagination.nextPage == null) {
      return;
    }

    // * Update filter dengan next page dari pagination
    final newFilter = currentFilter.copyWith(
      page:
          pagination.nextPage!, // * Safe to use ! karena sudah di-check di atas
    );
    _filterByScreen[screen] = newFilter;

    final operationType = _getOperationTypeForScreen(screen);

    _updateOperationState(
      operationType,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _getDataForScreen(screen, newFilter);

      // * Append new data to existing list
      _authorsByScreen[screen] = [
        ...(_authorsByScreen[screen] ?? []),
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

  // * Helper method to check if it's initial load
  bool isInitialLoad(AuthorScreenType screen) {
    return isLoading(_getOperationTypeForScreen(screen)) &&
        (_authorsByScreen[screen]?.isEmpty ?? true);
  }

  // *============*function yang gak langsung fetch api*============*
  // * Helper method untuk mendapatkan operation type berdasarkan screen
  AuthorOperationType _getOperationTypeForScreen(AuthorScreenType screen) {
    switch (screen) {
      case AuthorScreenType.authors:
        return AuthorOperationType.getAuthors;
      case AuthorScreenType.authorDetail:
        return AuthorOperationType.getAuthors;
      case AuthorScreenType.authorsFollowed:
        return AuthorOperationType.getAuthorsFollowed;
      case AuthorScreenType.search:
        return AuthorOperationType.searchAuthors;
    }
  }

  // * Helper method untuk mendapatkan data berdasarkan screen
  Future<ApiSuccessResponse<List<AuthorModel>>> _getDataForScreen(
    AuthorScreenType screen,
    AuthorFilterModel filter,
  ) async {
    switch (screen) {
      case AuthorScreenType.authors:
        return await _authorServices.getAuthors(filter);
      case AuthorScreenType.authorDetail:
        return await _authorServices.getAuthors(filter);
      case AuthorScreenType.authorsFollowed:
        return await _authorServices.getAuthorsFollowed(filter);
      case AuthorScreenType.search:
        // * Asumsikan ada searchQuery yang disimpan
        final searchQuery = filter.searchQuery;
        if (searchQuery == null) {
          throw Exception('Search query is required for search screen');
        }
        return await _authorServices.searchAuthorsByName(name: searchQuery);
    }
  }

  void resetSearch() {
    _authorsByScreen[AuthorScreenType.search] = [];
    _paginationByScreen[AuthorScreenType.search] = null;
    notifyListeners();
  }

  // * Optimistik update
  // * Map untuk menyimpan timer debounce per author
  final Map<String, Timer> _followDebounceTimers = {};
  // * Duration untuk debounce
  static const _debounceDuration = Duration(milliseconds: 500);

  // * Method untuk update status follow secara optimistic
  void updateAuthorFollowStatus(String authorId, bool isFollowed) {
    // * Update di semua screen yang menyimpan author
    _authorsByScreen.forEach((screen, authors) {
      final authorIndex = authors.indexWhere((author) => author.id == authorId);
      if (authorIndex != -1) {
        final updatedAuthors = List<AuthorModel>.from(authors);
        updatedAuthors[authorIndex] = authors[authorIndex].copyWith(
          isFollowedAuthor: isFollowed,
          followerCount: isFollowed
              ? authors[authorIndex].followerCount + 1
              : authors[authorIndex].followerCount - 1,
        );
        _authorsByScreen[screen] = updatedAuthors;
      }
    });

    // * Update untuk single author detail
    if (_authorCache[authorId]?.id == authorId) {
      _authorCache[authorId] = _authorCache[authorId]!.copyWith(
        isFollowedAuthor: isFollowed,
        followerCount: isFollowed
            ? _authorCache[authorId]!.followerCount + 1
            : _authorCache[authorId]!.followerCount - 1,
      );
    }

    notifyListeners();
  }

  // * Method untuk rollback status follow
  void rollbackAuthorFollowStatus(String authorId) {
    // * Rollback di semua screen
    _authorsByScreen.forEach((screen, authors) {
      final authorIndex = authors.indexWhere((author) => author.id == authorId);
      if (authorIndex != -1) {
        final updatedAuthors = List<AuthorModel>.from(authors);
        updatedAuthors[authorIndex] = authors[authorIndex].copyWith(
          isFollowedAuthor: authors[authorIndex].originalFollowStatus,
          followerCount: authors[authorIndex].originalFollowStatus
              ? authors[authorIndex].followerCount + 1
              : authors[authorIndex].followerCount - 1,
        );
        _authorsByScreen[screen] = updatedAuthors;
      }
    });

    // * Rollback untuk single author detail
    if (_authorCache[authorId]?.id == authorId) {
      _authorCache[authorId] = _authorCache[authorId]!.copyWith(
        isFollowedAuthor: _authorCache[authorId]!.originalFollowStatus,
        followerCount: _authorCache[authorId]!.originalFollowStatus
            ? _authorCache[authorId]!.followerCount + 1
            : _authorCache[authorId]!.followerCount - 1,
      );
    }

    notifyListeners();
  }

  // * Method untuk handle follow/unfollow dengan debounce
  Future<void> toggleFollowAuthor(String authorId) async {
    // * Cari author di semua screen
    AuthorModel? targetAuthor;
    for (var authors in _authorsByScreen.values) {
      targetAuthor = authors.firstWhere(
        (author) => author.id == authorId,
        orElse: () => targetAuthor ?? _authorCache[authorId]!,
      );
      break;
    }

    if (targetAuthor == null) return;

    // * Cancel timer yang sedang berjalan (jika ada)
    _followDebounceTimers[authorId]?.cancel();

    // * Update UI secara optimistic
    final newFollowStatus = !targetAuthor.isFollowedAuthor;
    updateAuthorFollowStatus(authorId, newFollowStatus);

    // * Set timer baru untuk debounce
    _followDebounceTimers[authorId] = Timer(_debounceDuration, () async {
      // * Cek apakah status berubah dari original
      final currentAuthor = _findAuthorById(authorId);
      if (currentAuthor == null) return;

      if (currentAuthor.isFollowedAuthor !=
          currentAuthor.originalFollowStatus) {
        try {
          if (currentAuthor.isFollowedAuthor) {
            await followAuthorById(authorId);
          } else {
            await unfollowAuthorById(authorId);
          }

          // * Update original status setelah berhasil
          _updateOriginalFollowStatus(authorId, currentAuthor.isFollowedAuthor);
        } catch (e) {
          // * Rollback jika gagal
          rollbackAuthorFollowStatus(authorId);
          debugPrint('Error toggling follow status: $e');
        }
      }
    });
  }

  // * Helper method untuk mencari author di semua screen
  AuthorModel? _findAuthorById(String authorId) {
    for (var authors in _authorsByScreen.values) {
      final author =
          authors.where((author) => author.id == authorId).firstOrNull;
      if (author != null) return author;
    }
    return _authorCache[authorId]?.id == authorId
        ? _authorCache[authorId]
        : null;
  }

  // * Helper method untuk update original follow status
  void _updateOriginalFollowStatus(String authorId, bool newStatus) {
    _authorsByScreen.forEach((screen, authors) {
      final authorIndex = authors.indexWhere((author) => author.id == authorId);
      if (authorIndex != -1) {
        final updatedAuthors = List<AuthorModel>.from(authors);
        updatedAuthors[authorIndex] = authors[authorIndex].copyWith(
          originalFollowStatus: newStatus,
        );
        _authorsByScreen[screen] = updatedAuthors;
      }
    });

    if (_authorCache[authorId]?.id == authorId) {
      _authorCache[authorId] =
          _authorCache[authorId]!.copyWith(originalFollowStatus: newStatus);
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
