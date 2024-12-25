import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/feature/genre/enum_genre_operation.dart';
import 'package:book_app_basic_arch/feature/genre/genre_model.dart';
import 'package:book_app_basic_arch/feature/genre/genre_services.dart';
import 'package:flutter/material.dart';

class GenreProvider with ChangeNotifier {
  final GenreServices _genreServices = GenreServices();

  List<GenreModel> _genres = [];
  List<GenreModel> get genres => _genres;
  GenreModel? _genre;
  GenreModel? get genre => _genre;

  // * Map untuk store operation state
  final Map<EnumGenreOperation, OperationState> _operationStates = {
    for (var operation in EnumGenreOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumGenreOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumGenreOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumGenreOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createGenre(CreateGenreModel genre) async {
    _updateOperationState(
      EnumGenreOperation.create,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.createGenre(genre);
      await getGenres();

      _updateOperationState(
        EnumGenreOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumGenreOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getGenres() async {
    _updateOperationState(
      EnumGenreOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _genreServices.getGenres();

      _genres = response.data!;

      _updateOperationState(
        EnumGenreOperation.getAll,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumGenreOperation.getAll,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> getGenreById(String id) async {
    _updateOperationState(
      EnumGenreOperation.getById,
      isLoading: true,
      errorMessage: null,
    );
    try {
      final response = await _genreServices.getGenreById(id);

      _genre = response.data!;

      _updateOperationState(
        EnumGenreOperation.getById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumGenreOperation.getById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> updateGenre(UpdateGenreModel genre) async {
    _updateOperationState(
      EnumGenreOperation.update,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _genreServices.updateGenreById(genre);
      await getGenreById(genre.id);
      await getGenres();

      _updateOperationState(
        EnumGenreOperation.update,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumGenreOperation.update,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating genre: $e');
    }
  }

  Future<void> deleteGenre(String id) async {
    _updateOperationState(
      EnumGenreOperation.delete,
      isLoading: true,
      errorMessage: null,
    );
    try {
      await _genreServices.deleteGenreById(id);
      await getGenres();

      _updateOperationState(
        EnumGenreOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumGenreOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating genre: $e');
    }
  }
}
