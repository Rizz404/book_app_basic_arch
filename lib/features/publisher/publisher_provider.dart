import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_services.dart';
import 'package:book_app_basic_arch/features/publisher/enum_publisher_operation.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';

class PublisherProvider with ChangeNotifier {
  final PublisherServices _publisherServices = PublisherServices();

  List<PublisherModel> _publishers = [];
  List<PublisherModel> get publishers => _publishers;
  PublisherModel? _publisher;
  PublisherModel? get publisher => _publisher;

  // * Map untuk store operation state
  final Map<EnumPublisherOperation, OperationState> _operationStates = {
    for (var operation in EnumPublisherOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumPublisherOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumPublisherOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(EnumPublisherOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createPublisher(CreatePublisherModel publisher) async {
    _updateOperationState(EnumPublisherOperation.create, isLoading: true);
    notifyListeners();
    try {
      await _publisherServices.createPublisher(publisher);

      await getPublishers();
    } catch (e) {
      _updateOperationState(EnumPublisherOperation.create,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching publishers: $e');
    } finally {
      _updateOperationState(EnumPublisherOperation.create, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getPublishers() async {
    _updateOperationState(EnumPublisherOperation.getAll, isLoading: true);
    notifyListeners();
    try {
      final response = await _publisherServices.getPublishers();

      _publishers = response.data!;
    } catch (e) {
      _updateOperationState(EnumPublisherOperation.getAll,
          errorMessage: 'Error fetching genres: $e');
      debugPrint('Error fetching publishers: $e');
    } finally {
      _updateOperationState(EnumPublisherOperation.getAll, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getPublisherById(String id) async {
    _updateOperationState(EnumPublisherOperation.getById, isLoading: true);
    notifyListeners();
    try {
      final response = await _publisherServices.getPublisherById(id);

      _publisher = response.data!;
    } catch (e) {
      _updateOperationState(EnumPublisherOperation.getById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching publishers: $e');
    } finally {
      _updateOperationState(EnumPublisherOperation.getById, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> updatePublisher(UpdatePublisherModel publisher) async {
    _updateOperationState(EnumPublisherOperation.update, isLoading: true);
    notifyListeners();

    try {
      await _publisherServices.updatePublisherById(publisher);

      await getPublisherById(publisher.id);
      await getPublishers();
    } catch (e) {
      _updateOperationState(EnumPublisherOperation.update,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating publisher: $e');
    } finally {
      _updateOperationState(EnumPublisherOperation.update, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deletePublisher(String id) async {
    _updateOperationState(EnumPublisherOperation.delete, isLoading: true);
    notifyListeners();

    try {
      await _publisherServices.deletePublisherById(id);
      await getPublishers();
    } catch (e) {
      _updateOperationState(EnumPublisherOperation.delete,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating publisher: $e');
    } finally {
      _updateOperationState(EnumPublisherOperation.delete, isLoading: false);
      notifyListeners();
    }
  }
}
