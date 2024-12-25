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
    _updateOperationState(
      EnumAuthorOperation.create,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.createAuthor(author);
      await getAuthors();

      _updateOperationState(
        EnumAuthorOperation.create,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthorOperation.create,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> getAuthors() async {
    _updateOperationState(
      EnumAuthorOperation.getAll,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthors();

      _authors = response.data!;

      _updateOperationState(
        EnumAuthorOperation.getAll,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthorOperation.getAll,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> getAuthorById(String id) async {
    _updateOperationState(
      EnumAuthorOperation.getById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authorServices.getAuthorById(id);

      _author = response.data!;

      _updateOperationState(
        EnumAuthorOperation.getById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthorOperation.getById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching authors: $e');
    }
  }

  Future<void> updateAuthor(UpdateAuthorModel author) async {
    _updateOperationState(
      EnumAuthorOperation.update,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.updateAuthorById(author);

      await getAuthorById(author.id);
      await getAuthors();

      _updateOperationState(
        EnumAuthorOperation.update,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthorOperation.update,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating author: $e');
    }
  }

  Future<void> deleteAuthor(String id) async {
    _updateOperationState(
      EnumAuthorOperation.delete,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authorServices.deleteAuthorById(id);
      await getAuthors();

      _updateOperationState(
        EnumAuthorOperation.delete,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthorOperation.delete,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating author: $e');
    }
  }
}
