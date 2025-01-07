import 'dart:io';

import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_services.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_filter_model.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:flutter/material.dart';

class GenreProvider with ChangeNotifier {
  final GenreServices _genreServices = GenreServices();

  // * State untuk menyimpan genres per screen
  final Map<GenreScreenType, List<GenreModel>> _genresByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<GenreScreenType, ApiPagination?> _paginationByScreen = {};

  // * Getter untuk hasil search (pake map yang sama)
  List<GenreModel> get searchedGenres =>
      _genresByScreen[GenreScreenType.search] ?? [];

  ApiPagination? get searchedGenresPagination =>
      _paginationByScreen[GenreScreenType.search];

  // * Cache untuk genre berdasarkan ID
  final Map<String, GenreModel> _genreCache = {};

  // * Getter untuk single genre dari cache
  GenreModel? getGenreByIdFromCache(String id) => _genreCache[id];

  // * State untuk menyimpan filter tiap screen
  final Map<GenreScreenType, GenreFilterModel> _filterByScreen = {
    GenreScreenType.home: const GenreFilterModel(),
    GenreScreenType.genres: const GenreFilterModel(),
    GenreScreenType.genreDetail: const GenreFilterModel(),
    GenreScreenType.search: const GenreFilterModel(),
  };

  // * Getter untuk genres berdasarkan screen
  List<GenreModel> getGenresForSpecificScreen(GenreScreenType screen) {
    return _genresByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(GenreScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  GenreFilterModel getFilterForSpecificScreen(GenreScreenType screen) {
    return _filterByScreen[screen] ?? const GenreFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      GenreScreenType screen, GenreFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

  // * Map untuk store operation state
  final Map<GenreOperationType, OperationState> _operationStates = {
    for (var operation in GenreOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(GenreOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(GenreOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  void _updateOperationState(GenreOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createGenre(
    CreateGenreModel genre,
    File? picture,
  ) async {
    _updateOperationState(
      GenreOperationType.createGenre,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.createGenre(genre, picture);
      // Clear all cache karena ada data baru
      _clearAllCache();

      // Refresh semua screen setelah cache dibersihkan
      await _refreshAllScreens();

      _updateOperationState(
        GenreOperationType.createGenre,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        GenreOperationType.createGenre,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getGenres({
    GenreScreenType screen = GenreScreenType.genres,
    bool refresh = false,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      GenreOperationType.getGenres,
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _genreServices.getGenres(
        filter,
        forceRefresh: refresh,
      );

      _genresByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        GenreOperationType.getGenres,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        GenreOperationType.getGenres,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> getGenreById(String id, {bool forceRefresh = false}) async {
    // Perbarui logika caching
    if (!forceRefresh && _genreCache.containsKey(id)) {
      return;
    }

    _updateOperationState(
      GenreOperationType.getGenreById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _genreServices.getGenreById(id);
      _genreCache[id] = response.data!;

      _updateOperationState(
        GenreOperationType.getGenreById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // Hapus dari cache jika error
      _invalidateCache(id);

      _updateOperationState(
        GenreOperationType.getGenreById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching genre by id: $e');
    }
  }

  Future<void> searchGenresByName({
    required String name,
  }) async {
    // * Reset filter search ke page 1 dengan query baru
    final newFilter = GenreFilterModel(
      page: 1,
      searchQuery: name,
    );
    _filterByScreen[GenreScreenType.search] = newFilter;

    _updateOperationState(
      GenreOperationType.searchGenres,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _genreServices.searchGenresByName(name: name);

      _genresByScreen[GenreScreenType.search] = response.data!;
      _paginationByScreen[GenreScreenType.search] = response.meta.pagination;

      _updateOperationState(
        GenreOperationType.searchGenres,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        GenreOperationType.searchGenres,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error searching genres: $e');
    }
  }

  Future<void> updateGenre(
    UpdateGenreModel genre,
    File? picture,
  ) async {
    _updateOperationState(
      GenreOperationType.updateGenreById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _genreServices.updateGenreById(genre, picture);
      // Invalidate cache untuk genre yang diupdate
      _invalidateCache(genre.id);

      // Fetch ulang data genre yang diupdate
      await getGenreById(genre.id, forceRefresh: true);

      // Refresh semua screen setelah cache diperbarui
      await _refreshAllScreens();

      _updateOperationState(
        GenreOperationType.updateGenreById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        GenreOperationType.updateGenreById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating genre: $e');
    }
  }

  Future<void> deleteGenreById(String id) async {
    _updateOperationState(
      GenreOperationType.deleteGenreById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.deleteGenreById(id);
      await _genreServices.deleteGenreById(id);

      // Invalidate cache untuk genre yang dihapus
      _invalidateCache(id);

      // Refresh semua screen setelah cache diperbarui
      await _refreshAllScreens();

      _updateOperationState(
        GenreOperationType.deleteGenreById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        GenreOperationType.deleteGenreById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating genre: $e');
    }
  }

  // * Method generic untuk load more data
  bool canLoadMore(GenreScreenType screen) {
    final pagination = _paginationByScreen[screen];
    return pagination?.hasNextPage ?? false;
  }

  Future<void> loadMoreGenres(GenreScreenType screen) async {
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
      _genresByScreen[screen] = [
        ...(_genresByScreen[screen] ?? []),
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

  Future<void> _refreshAllScreens() async {
    try {
      // Simpan filter yang sedang aktif untuk setiap screen
      final currentFilters =
          Map<GenreScreenType, GenreFilterModel>.from(_filterByScreen);

      // Refresh data untuk setiap screen
      for (var screen in GenreScreenType.values) {
        if (_genresByScreen[screen]?.isNotEmpty ?? false) {
          // Gunakan filter yang sedang aktif untuk screen tersebut
          final filter = currentFilters[screen]!;
          final response = await _getDataForScreen(screen, filter);
          _genresByScreen[screen] = response.data!;
          _paginationByScreen[screen] = response.meta.pagination;
        }
      }

      // Notify listeners setelah semua screen diperbarui
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing screens: $e');
      // Bisa tambahkan error handling tambahan jika diperlukan
    }
  }

  // * Helper method to check if it's initial load
  bool isInitialLoad(GenreScreenType screen) {
    return isLoading(_getOperationTypeForScreen(screen)) &&
        (_genresByScreen[screen]?.isEmpty ?? true);
  }

  // * *============*function yang gak langsung fetch api*============*
  // * Helper method untuk mendapatkan operation type berdasarkan screen
  GenreOperationType _getOperationTypeForScreen(GenreScreenType screen) {
    switch (screen) {
      case GenreScreenType.home:
        return GenreOperationType.getGenres;
      case GenreScreenType.genres:
        return GenreOperationType.getGenres;
      case GenreScreenType.search:
        return GenreOperationType.searchGenres;
      case GenreScreenType.genreDetail:
        return GenreOperationType.getGenres;
    }
  }

  // * Helper method untuk mendapatkan data berdasarkan screen
  Future<ApiSuccessResponse<List<GenreModel>>> _getDataForScreen(
    GenreScreenType screen,
    GenreFilterModel filter,
  ) async {
    switch (screen) {
      case GenreScreenType.home:
        return await _genreServices.getGenres(filter);
      case GenreScreenType.genres:
        return await _genreServices.getGenres(filter);
      case GenreScreenType.search:
        // * Asumsikan ada searchQuery yang disimpan
        final searchQuery = filter.searchQuery;
        if (searchQuery == null) {
          throw Exception('Search query is required for search screen');
        }
        return await _genreServices.searchGenresByName(name: searchQuery);
      case GenreScreenType.genreDetail:
        return await _genreServices.getGenres(filter);
    }
  }

  void resetSearch() {
    _genresByScreen[GenreScreenType.search] = [];
    _paginationByScreen[GenreScreenType.search] = null;
    notifyListeners();
  }

  // Tambahkan method untuk invalidate cache
  void _invalidateCache(String id) {
    _genreCache.remove(id);
  }

  // Tambahkan method untuk clear semua cache
  void _clearAllCache() {
    _genreCache.clear();
  }
}
