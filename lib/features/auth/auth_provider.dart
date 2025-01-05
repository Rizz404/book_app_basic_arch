import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/auth/auth_services.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:book_app_basic_arch/features/auth/enums/auth_operation_type.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  UserCredentialModel? _userCredential;
  UserCredentialModel? get userCredential => _userCredential;

  // Tambahkan state untuk tracking inisialisasi
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AuthProvider() {
    _initializeCredentials();
  }

  Future<void> _initializeCredentials() async {
    try {
      _userCredential = await _authServices.getCurrentCredentials();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing credentials: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Modifikasi getter isAuthenticated
  bool get isAuthenticated {
    // Hanya return true jika sudah diinisialisasi dan ada credential
    return _isInitialized && _userCredential != null;
  }

  // * Map untuk store operation state
  final Map<AuthOperationType, OperationState> _operationStates = {
    for (var operation in AuthOperationType.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(AuthOperationType operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(AuthOperationType operation) =>
      _operationStates[operation]!.errorMessage;

  // * Helper untuk update operation state
  void _updateOperationState(AuthOperationType operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> signUp(SignUpModel payload) async {
    _updateOperationState(
      AuthOperationType.signUp,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authServices.signUp(payload);

      _updateOperationState(
        AuthOperationType.signUp,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthOperationType.signUp,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> signIn(SignInModel payload) async {
    _updateOperationState(
      AuthOperationType.signIn,
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authServices.signIn(payload);
      _userCredential = response.data;

      _updateOperationState(
        AuthOperationType.signIn,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthOperationType.signIn,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    _updateOperationState(
      AuthOperationType.signOut,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authServices.signOut();
      _userCredential = null;

      _updateOperationState(
        AuthOperationType.signOut,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        AuthOperationType.signOut,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }
}
