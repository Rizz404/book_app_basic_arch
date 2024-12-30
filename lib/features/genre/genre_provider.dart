import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
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

  // * Beda buat search
  List<GenreModel> _searchedGenres = [];
  List<GenreModel> get searchedGenres => _searchedGenres;
  ApiPagination? _searchedGenresPagination;
  ApiPagination? get searchedGenresPagination => _searchedGenresPagination;

  // * State untuk single genre detail
  GenreModel? _genre;
  GenreModel? get genre => _genre;

  // * State untuk menyimpan filter tiap screen
  final Map<GenreScreenType, GenreFilterModel> _filterByScreen = {
    GenreScreenType.home: GenreFilterModel(),
    GenreScreenType.genres: GenreFilterModel(),
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
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      GenreOperationType.getGenres,
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _genreServices.getGenres(filter);

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
    _updateOperationState(
      GenreOperationType.getGenreById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _genreServices.getGenreById(id);

      _genre = response.data!;

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
}
