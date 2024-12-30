import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_filter_model.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_services.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';

class PublisherProvider with ChangeNotifier {
  final PublisherServices _publisherServices = PublisherServices();
// * State untuk menyimpan publishers per screen
  final Map<PublisherScreenType, List<PublisherModel>> _publishersByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<PublisherScreenType, ApiPagination?> _paginationByScreen = {};

  // * Beda buat search
  List<PublisherModel> _searchedPublishers = [];
  List<PublisherModel> get searchedPublishers => _searchedPublishers;
  ApiPagination? _searchedPublishersPagination;
  ApiPagination? get searchedPublishersPagination =>
      _searchedPublishersPagination;

  // * State untuk single publisher detail
  PublisherModel? _publisher;
  PublisherModel? get publisher => _publisher;

  // * State untuk menyimpan filter tiap screen
  final Map<PublisherScreenType, PublisherFilterModel> _filterByScreen = {
    PublisherScreenType.publishers: PublisherFilterModel(),
  };

  // * Getter untuk publishers berdasarkan screen
  List<PublisherModel> getPublishersForSpecificScreen(
      PublisherScreenType screen) {
    return _publishersByScreen[screen] ?? [];
  }

  // * Getter untuk pagination berdasarkan screen
  ApiPagination? getPaginationForSpecificScreen(PublisherScreenType screen) {
    return _paginationByScreen[screen];
  }

  // * Getter untuk filter berdasarkan screen
  PublisherFilterModel getFilterForSpecificScreen(PublisherScreenType screen) {
    return _filterByScreen[screen] ?? PublisherFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      PublisherScreenType screen, PublisherFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
    notifyListeners();
  }

  // * Map untuk store operation state
  final Map<PublisherOperationType, OperationState> _operationStates = {
    for (var operation in PublisherOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(PublisherOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(PublisherOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  // Helper to update operation state
  void _updateOperationState(PublisherOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createPublisher(CreatePublisherModel publisher) async {
    _updateOperationState(PublisherOperationType.createPublisher,
        isLoading: true);
    notifyListeners();
    try {
      await _publisherServices.createPublisher(publisher);

      await getPublishers();
    } catch (e) {
      _updateOperationState(PublisherOperationType.createPublisher,
          errorMessage: 'Error creating genre: $e');
      debugPrint('Error fetching publishers: $e');
    } finally {
      _updateOperationState(PublisherOperationType.createPublisher,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> getPublishers({
    PublisherScreenType screen = PublisherScreenType.publishers,
  }) async {
    final filter = _filterByScreen[screen]!;

    _updateOperationState(
      PublisherOperationType.getPublishers,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _publisherServices.getPublishers(filter);

      _publishersByScreen[screen] = response.data!;
      _paginationByScreen[screen] = response.meta.pagination;

      _updateOperationState(
        PublisherOperationType.getPublishers,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.getPublishers,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching publishers: $e');
    }
  }

  Future<void> getPublisherById(String id) async {
    _updateOperationState(PublisherOperationType.getPublisherById,
        isLoading: true);
    notifyListeners();
    try {
      final response = await _publisherServices.getPublisherById(id);

      _publisher = response.data!;
    } catch (e) {
      _updateOperationState(PublisherOperationType.getPublisherById,
          errorMessage: 'Error fetching genre: $e');
      debugPrint('Error fetching publishers: $e');
    } finally {
      _updateOperationState(PublisherOperationType.getPublisherById,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> searchPublishersByName({
    int page = 1,
    int limit = 10,
    required String name,
  }) async {
    _updateOperationState(
      PublisherOperationType.searchPublishers,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _publisherServices.searchPublishersByName(
        name: name,
      );

      _searchedPublishers = response.data!;
      _searchedPublishersPagination = response.meta.pagination;

      _updateOperationState(
        PublisherOperationType.searchPublishers,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.searchPublishers,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching publishers: $e');
    }
  }

  void resetSearch() {
    _searchedPublishers = [];
    notifyListeners();
  }

  Future<void> updatePublisher(UpdatePublisherModel publisher) async {
    _updateOperationState(PublisherOperationType.updatePublisherById,
        isLoading: true);
    notifyListeners();

    try {
      await _publisherServices.updatePublisherById(publisher);

      await getPublisherById(publisher.id);
      await getPublishers();
    } catch (e) {
      _updateOperationState(PublisherOperationType.updatePublisherById,
          errorMessage: 'Error updating genre: $e');
      debugPrint('Error updating publisher: $e');
    } finally {
      _updateOperationState(PublisherOperationType.updatePublisherById,
          isLoading: false);
      notifyListeners();
    }
  }

  Future<void> deletePublisher(String id) async {
    _updateOperationState(PublisherOperationType.deletePublisherById,
        isLoading: true);
    notifyListeners();

    try {
      await _publisherServices.deletePublisherById(id);
      await getPublishers();
    } catch (e) {
      _updateOperationState(PublisherOperationType.deletePublisherById,
          errorMessage: 'Error deleting genre: $e');
      debugPrint('Error updating publisher: $e');
    } finally {
      _updateOperationState(PublisherOperationType.deletePublisherById,
          isLoading: false);
      notifyListeners();
    }
  }
}
