import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/language/language_services.dart';
import 'package:book_app_basic_arch/features/language/enum_language_operation.dart';
import 'package:book_app_basic_arch/features/language/model/language_model.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  final LanguageServices _languageServices = LanguageServices();

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;
  LanguageModel? _language;
  LanguageModel? get language => _language;

  // * Map untuk store operation state
  final Map<EnumLanguageOperation, OperationState> _operationStates = {
    for (var operation in EnumLanguageOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumLanguageOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumLanguageOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumLanguageOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createLanguage(CreateLanguageModel language) async {
    _updateOperationState(EnumLanguageOperation.create, isLoading: true);
    notifyListeners();
    try {
      await _languageServices.createLanguage(language);

      await getLanguages();
    } catch (e) {
      _updateOperationState(EnumLanguageOperation.create,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching languages: $e');
    } finally {
      _updateOperationState(EnumLanguageOperation.create, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getLanguages({
    int page = 1,
    int limit = 10,
  }) async {
    _updateOperationState(EnumLanguageOperation.getAll, isLoading: true);
    notifyListeners();
    try {
      final response = await _languageServices.getLanguages();

      _languages = response.data!;
    } catch (e) {
      _updateOperationState(EnumLanguageOperation.getAll,
          errorMessage: 'Error fetching genres: $e');
      debugPrint('Error fetching languages: $e');
    } finally {
      _updateOperationState(EnumLanguageOperation.getAll, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getLanguageById(String id) async {
    _updateOperationState(EnumLanguageOperation.getById, isLoading: true);
    notifyListeners();
    try {
      final response = await _languageServices.getLanguageById(id);

      _language = response.data!;
    } catch (e) {
      _updateOperationState(EnumLanguageOperation.getById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching languages: $e');
    } finally {
      _updateOperationState(EnumLanguageOperation.getById, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updateLanguage(UpdateLanguageModel language) async {
    _updateOperationState(EnumLanguageOperation.update, isLoading: true);
    notifyListeners();

    try {
      await _languageServices.updateLanguageById(language);

      await getLanguageById(language.id);
      await getLanguages();
    } catch (e) {
      _updateOperationState(EnumLanguageOperation.update,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating language: $e');
    } finally {
      _updateOperationState(EnumLanguageOperation.update, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deleteLanguage(String id) async {
    _updateOperationState(EnumLanguageOperation.delete, isLoading: true);
    notifyListeners();

    try {
      await _languageServices.deleteLanguageById(id);
      await getLanguages();
    } catch (e) {
      _updateOperationState(EnumLanguageOperation.delete,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating language: $e');
    } finally {
      _updateOperationState(EnumLanguageOperation.delete, isLoading: false);
      notifyListeners();
    }
  }
}
