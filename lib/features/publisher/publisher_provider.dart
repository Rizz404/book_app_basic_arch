import 'package:book_app_basic_arch/core/network/models/api_pagination.dart';
import 'package:book_app_basic_arch/core/network/models/api_success_response.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_screen_type.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_filter_model.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_services.dart';
import 'package:flutter/material.dart';

class PublisherProvider with ChangeNotifier {
  final PublisherServices _publisherServices = PublisherServices();

  // * State untuk menyimpan publishers per screen
  final Map<PublisherScreenType, List<PublisherModel>> _publishersByScreen = {};
  // * State untuk menyimpan pagination per screen
  final Map<PublisherScreenType, ApiPagination?> _paginationByScreen = {};

  // * Getter untuk hasil search (pake map yang sama)
  List<PublisherModel> get searchedPublishers =>
      _publishersByScreen[PublisherScreenType.search] ?? [];

  ApiPagination? get searchedPublishersPagination =>
      _paginationByScreen[PublisherScreenType.search];

  // * Cache untuk publisher berdasarkan ID
  final Map<String, PublisherModel> _publisherCache = {};

  // * Getter untuk single publisher dari cache
  PublisherModel? getPublisherByIdFromCache(String id) => _publisherCache[id];

  // * State untuk menyimpan filter tiap screen
  final Map<PublisherScreenType, PublisherFilterModel> _filterByScreen = {
    PublisherScreenType.publishers: const PublisherFilterModel(),
    PublisherScreenType.publisherDetail: const PublisherFilterModel(),
    PublisherScreenType.search: const PublisherFilterModel(),
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
    return _filterByScreen[screen] ?? const PublisherFilterModel();
  }

  // * Method untuk update filter
  void updateFilterForSpecificScreen(
      PublisherScreenType screen, PublisherFilterModel newFilter) {
    _filterByScreen[screen] = newFilter;
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

  // * Helper to update operation state
  void _updateOperationState(PublisherOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> createPublisher(CreatePublisherModel publisher) async {
    _updateOperationState(
      PublisherOperationType.createPublisher,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _publisherServices.createPublisher(publisher);
      await getPublishers();

      _updateOperationState(
        PublisherOperationType.createPublisher,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.createPublisher,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching publishers: $e');
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
    // * Cek cache terlebih dahulu
    if (_publisherCache.containsKey(id)) {
      return; // * Tidak perlu fetch jika sudah ada di cache dan refresh false
    }

    _updateOperationState(
      PublisherOperationType.getPublisherById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _publisherServices.getPublisherById(id);

      _publisherCache[id] = response.data!;

      _updateOperationState(
        PublisherOperationType.getPublisherById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.getPublisherById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error fetching publishers: $e');
    }
  }

  Future<void> searchPublishersByName({
    required String name,
  }) async {
    // * Reset filter search ke page 1 dengan query baru
    final newFilter = PublisherFilterModel(
      page: 1,
      searchQuery: name,
    );
    _filterByScreen[PublisherScreenType.search] = newFilter;

    _updateOperationState(
      PublisherOperationType.searchPublishers,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response =
          await _publisherServices.searchPublishersByName(name: name);

      _publishersByScreen[PublisherScreenType.search] = response.data!;
      _paginationByScreen[PublisherScreenType.search] =
          response.meta.pagination;

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
      debugPrint('Error searching publishers: $e');
    }
  }

  Future<void> updatePublisher(UpdatePublisherModel publisher) async {
    _updateOperationState(
      PublisherOperationType.updatePublisherById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _publisherServices.updatePublisherById(publisher);

      await getPublisherById(publisher.id);
      await getPublishers();

      _updateOperationState(
        PublisherOperationType.updatePublisherById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.updatePublisherById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating publisher: $e');
    }
  }

  Future<void> deletePublisher(String id) async {
    _updateOperationState(
      PublisherOperationType.deletePublisherById,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _publisherServices.deletePublisherById(id);
      await getPublishers();

      _updateOperationState(
        PublisherOperationType.deletePublisherById,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        PublisherOperationType.deletePublisherById,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint('Error updating publisher: $e');
    }
  }

  // * Method generic untuk load more data
  Future<void> loadMorePublishers(PublisherScreenType screen) async {
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
      _publishersByScreen[screen] = [
        ...(_publishersByScreen[screen] ?? []),
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

  // *============*function yang gak langsung fetch api*============*
  // * Helper method untuk mendapatkan operation type berdasarkan screen
  PublisherOperationType _getOperationTypeForScreen(
      PublisherScreenType screen) {
    switch (screen) {
      case PublisherScreenType.publishers:
        return PublisherOperationType.getPublishers;
      case PublisherScreenType.publisherDetail:
        return PublisherOperationType.getPublishers;
      case PublisherScreenType.search:
        return PublisherOperationType.searchPublishers;
    }
  }

  // * Helper method untuk mendapatkan data berdasarkan screen
  Future<ApiSuccessResponse<List<PublisherModel>>> _getDataForScreen(
    PublisherScreenType screen,
    PublisherFilterModel filter,
  ) async {
    switch (screen) {
      case PublisherScreenType.publishers:
        return await _publisherServices.getPublishers(filter);
      case PublisherScreenType.publisherDetail:
        return await _publisherServices.getPublishers(filter);
      case PublisherScreenType.search:
        // * Asumsikan ada searchQuery yang disimpan
        final searchQuery = filter.searchQuery;
        if (searchQuery == null) {
          throw Exception('Search query is required for search screen');
        }
        return await _publisherServices.searchPublishersByName(
            name: searchQuery);
    }
  }

  void resetSearch() {
    _publishersByScreen[PublisherScreenType.search] = [];
    _paginationByScreen[PublisherScreenType.search] = null;
    notifyListeners();
  }
}
