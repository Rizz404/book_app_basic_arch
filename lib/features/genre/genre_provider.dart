import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_screen_type.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_filter_model.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/genre_services.dart';
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
    GenreScreenType.home: GenreFilterModel(),
    GenreScreenType.genres: GenreFilterModel(),
    GenreScreenType.genreDetail: GenreFilterModel(),
    GenreScreenType.search: GenreFilterModel(),
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
    return _filterByScreen[screen] ?? GenreFilterModel();
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

  Future<void> createGenre(CreateGenreModel genre) async {
    _updateOperationState(
      GenreOperationType.createGenre,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.createGenre(genre);
      await getGenres();

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

  Future<void> getGenreById(String id) async {
    // * Cek cache terlebih dahulu
    if (_genreCache.containsKey(id)) {
      return; // * Tidak perlu fetch jika sudah ada di cache dan refresh false
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
      _updateOperationState(
        GenreOperationType.getGenreById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching genres: $e');
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

  Future<void> updateGenre(UpdateGenreModel genre) async {
    _updateOperationState(
      GenreOperationType.updateGenreById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _genreServices.updateGenreById(genre);
      await getGenreById(genre.id);
      await getGenres();

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

  Future<void> deleteGenre(String id) async {
    _updateOperationState(
      GenreOperationType.deleteGenreById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.deleteGenreById(id);
      await getGenres();

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
  Future<void> loadMoreGenres(GenreScreenType screen) async {
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
}
