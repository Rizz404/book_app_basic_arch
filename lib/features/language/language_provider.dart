import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/language/enums/language_operation_type.dart';
import 'package:book_app_basic_arch/features/language/enums/language_screen_type.dart';
import 'package:book_app_basic_arch/features/language/language_services.dart';
import 'package:book_app_basic_arch/features/language/model/language_filter_model.dart';
import 'package:book_app_basic_arch/features/language/model/language_model.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  final LanguageServices _languageServices = LanguageServices();

  // * State untuk menyimpan languages per screen
  final Map<LanguageScreenType, List<LanguageModel>> _languagesByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<LanguageScreenType, ApiPagination?> _paginationByScreen = {};

  // * Beda buat search
  final List<LanguageModel> _searchedLanguages = [];
  List<LanguageModel> get searchedLanguages => _searchedLanguages;
  ApiPagination? _searchedLanguagesPagination;
  ApiPagination? get searchedLanguagesPagination =>
      _searchedLanguagesPagination;

  // * State untuk single language detail
  LanguageModel? _language;
  LanguageModel? get language => _language;

  // * State untuk menyimpan filter tiap screen
  final Map<LanguageScreenType, LanguageFilterModel> _filterByScreen = {
    LanguageScreenType.languages: const LanguageFilterModel(),
  };

  // * Getter untuk languages berdasarkan screen
  List<LanguageModel> getLanguagesForSpecificScreen(LanguageScreenType screen) {
    return _languagesByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(LanguageScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  LanguageFilterModel getFilterForSpecificScreen(LanguageScreenType screen) {
    return _filterByScreen[screen] ?? const LanguageFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      LanguageScreenType screen, LanguageFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

  // * Map untuk store operation state
  final Map<LanguageOperationType, OperationState> _operationStates = {
    for (var operation in LanguageOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(LanguageOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(LanguageOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(LanguageOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createLanguage(CreateLanguageModel language) async {
    _updateOperationState(LanguageOperationType.createLanguage,
        isLoading: true);
    notifyListeners();
    try {
      await _languageServices.createLanguage(language);

      await getLanguages();
    } catch (e) {
      _updateOperationState(LanguageOperationType.createLanguage,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching languages: $e');
    } finally {
      _updateOperationState(LanguageOperationType.createLanguage,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getLanguages({
    LanguageScreenType screen = LanguageScreenType.languages,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      LanguageOperationType.getLanguages,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _languageServices.getLanguages(filter);

      _languagesByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        LanguageOperationType.getLanguages,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        LanguageOperationType.getLanguages,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching languages: $e');
    }
  }

  Future<void> getLanguageById(String id) async {
    _updateOperationState(LanguageOperationType.getLanguageById,
        isLoading: true);
    notifyListeners();
    try {
      final response = await _languageServices.getLanguageById(id);

      _language = response.data!;
    } catch (e) {
      _updateOperationState(LanguageOperationType.getLanguageById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching languages: $e');
    } finally {
      _updateOperationState(LanguageOperationType.getLanguageById,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updateLanguage(UpdateLanguageModel language) async {
    _updateOperationState(LanguageOperationType.updateLanguageById,
        isLoading: true);
    notifyListeners();

    try {
      await _languageServices.updateLanguageById(language);

      await getLanguageById(language.id);
      await getLanguages();
    } catch (e) {
      _updateOperationState(LanguageOperationType.updateLanguageById,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating language: $e');
    } finally {
      _updateOperationState(LanguageOperationType.updateLanguageById,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deleteLanguage(String id) async {
    _updateOperationState(LanguageOperationType.deleteLanguageById,
        isLoading: true);
    notifyListeners();

    try {
      await _languageServices.deleteLanguageById(id);
      await getLanguages();
    } catch (e) {
      _updateOperationState(LanguageOperationType.deleteLanguageById,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating language: $e');
    } finally {
      _updateOperationState(LanguageOperationType.deleteLanguageById,
          isLoading: false);
      notifyListeners();
    }
  }
}
