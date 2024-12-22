import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/feature/author/author_services.dart';
import 'package:book_app_basic_arch/feature/author/enum_author_operation.dart';
import 'package:book_app_basic_arch/feature/author/model/author_model.dart';
import 'package:flutter/material.dart';

class AuthorProvider with ChangeNotifier {
  final AuthorServices _authorServices = AuthorServices();

  List<AuthorModel> _authors = [];
  List<AuthorModel> get authors => _authors;
  AuthorModel? _author;
  AuthorModel? get author => _author;

  // * Map untuk store operation state
  final Map<EnumAuthorOperation, OperationState> _operationStates = {
    for (var operation in EnumAuthorOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumAuthorOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumAuthorOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumAuthorOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createAuthor(CreateAuthorModel author) async {
    _updateOperationState(EnumAuthorOperation.create, isLoading: true);
    notifyListeners();
    try {
      await _authorServices.createAuthor(author);

      await getAuthors();
    } catch (e) {
      _updateOperationState(EnumAuthorOperation.create,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching authors: $e');
    } finally {
      _updateOperationState(EnumAuthorOperation.create, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getAuthors() async {
    _updateOperationState(EnumAuthorOperation.getAll, isLoading: true);
    notifyListeners();
    try {
      final response = await _authorServices.getAuthors();

      _authors = response.data!;
    } catch (e) {
      _updateOperationState(EnumAuthorOperation.getAll,
          errorMessage: 'Error fetching genres: $e');
      debugPrint('Error fetching authors: $e');
    } finally {
      _updateOperationState(EnumAuthorOperation.getAll, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getAuthorById(String id) async {
    _updateOperationState(EnumAuthorOperation.getById, isLoading: true);
    notifyListeners();
    try {
      final response = await _authorServices.getAuthorById(id);

      _author = response.data!;
    } catch (e) {
      _updateOperationState(EnumAuthorOperation.getById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching authors: $e');
    } finally {
      _updateOperationState(EnumAuthorOperation.getById, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updateAuthor(UpdateAuthorModel author) async {
    _updateOperationState(EnumAuthorOperation.update, isLoading: true);
    notifyListeners();

    try {
      await _authorServices.updateAuthorById(author);

      await getAuthorById(author.id);
      await getAuthors();
    } catch (e) {
      _updateOperationState(EnumAuthorOperation.update,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating author: $e');
    } finally {
      _updateOperationState(EnumAuthorOperation.update, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deleteAuthor(String id) async {
    _updateOperationState(EnumAuthorOperation.delete, isLoading: true);
    notifyListeners();

    try {
      await _authorServices.deleteAuthorById(id);
      await getAuthors();
    } catch (e) {
      _updateOperationState(EnumAuthorOperation.delete,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating author: $e');
    } finally {
      _updateOperationState(EnumAuthorOperation.delete, isLoading: false);
      notifyListeners();
    }
  }
}
