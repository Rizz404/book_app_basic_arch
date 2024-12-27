import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:flutter/foundation.dart';

class OperationStateHandler<T> with ChangeNotifier {
  // * Store states untuk berbagai operasi
  final Map<T, OperationState> _operationStates = {};

  // * Getter untuk mengambil state
  bool isLoading(T operation) =>
      _operationStates[operation]?.isLoading ?? false;

  String? getError(T operation) => _operationStates[operation]?.errorMessage;

  // * Helper untuk update state
  void updateState(T operation, {bool? isLoading, String? errorMessage}) {
    final currentState =
        _operationStates[operation] ?? (isLoading: false, errorMessage: null);

    _operationStates[operation] = (
      isLoading: isLoading ?? currentState.isLoading,
      errorMessage: errorMessage
    );

    notifyListeners();
  }
}
