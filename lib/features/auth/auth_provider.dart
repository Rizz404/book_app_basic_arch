import 'package:book_app_basic_arch/core/helpers/user_credential_manager.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/auth/auth_services.dart';
import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:book_app_basic_arch/features/auth/enums/auth_operation_type.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  final UserCredentialManager _credentialManager = UserCredentialManager();

  // * Langsung init jadinya
  AuthProvider() {
    _initUserCredentialManager();
  }

  UserCredentialModel? _userCredential;
  UserCredentialModel? get userCredential => _userCredential;

  // * Getters untuk tokens melalui UserCredentialManager
  String? get accessToken => _credentialManager.accessToken;
  String? get refreshToken => _credentialManager.refreshToken;

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

  Future<void> _initUserCredentialManager() async {
    await _credentialManager.init();
    // * Cek apakah ada token yang tersimpan
    await _loadUserCredentialsFromCache();
  }

  Future<void> _loadUserCredentialsFromCache() async {
    final String? cachedUsername = _credentialManager.username;
    final String? cachedEmail = _credentialManager.email;
    final String? cachedProfilePicture = _credentialManager.profilePicture;
    final String? cachedId = _credentialManager.id;
    final String? cachedAccessToken = _credentialManager.accessToken;
    final String? cachedRefreshToken = _credentialManager.refreshToken;

    if (cachedAccessToken != null && cachedRefreshToken != null) {
      _userCredential = UserCredentialModel(
        id: cachedId!,
        username: cachedUsername!,
        email: cachedEmail!,
        profilePicture: cachedProfilePicture!,
        accessToken: cachedAccessToken,
        refreshToken: cachedRefreshToken,
        role: '',
        isVerified: true,
        isEmailVerified: true,
        createdAt: DateTime(2017, 9, 7, 17, 30),
        updatedAt: DateTime(2017, 9, 7, 17, 30),
      );
    }
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

      if (_userCredential != null) {
        await _credentialManager.saveCredentials(
          id: _userCredential?.id,
          username: userCredential?.username,
          email: _userCredential?.email,
          profilePicture: _userCredential?.profilePicture,
          accessToken: _userCredential?.accessToken,
          refreshToken: _userCredential?.refreshToken,
        );
      }

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
      await _credentialManager.clearTokens();
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

  // * Cek apakah user sudah login
  bool get isAuthenticated => _userCredential != null;
}
