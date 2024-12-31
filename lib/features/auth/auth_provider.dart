import 'package:book_app_basic_arch/core/helpers/current_user_credential_manager.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/features/auth/auth_services.dart';
import 'package:book_app_basic_arch/features/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/features/auth/model/remote/auth_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  final CurrentUserCredentialManager _credentialManager =
      CurrentUserCredentialManager();

  // * Langsung init jadinya
  AuthProvider() {
    _initCurrentUserCredentialManager();
  }

  UserCredentialModel? _userCredential;
  UserCredentialModel? get userCredential => _userCredential;

  // * Getters untuk tokens melalui CurrentUserCredentialManager
  String? get accessToken => _credentialManager.accessToken;
  String? get refreshToken => _credentialManager.refreshToken;

  // * Map untuk store operation state
  final Map<EnumAuthOperation, OperationState> _operationStates = {
    for (var operation in EnumAuthOperation.values)
      operation: (isLoading: false, errorMessage: null)
  };

  // * Getter untuk state
  bool isLoading(EnumAuthOperation operation) =>
      _operationStates[operation]!.isLoading;
  String? getError(EnumAuthOperation operation) =>
      _operationStates[operation]!.errorMessage;

  // * Helper untuk update operation state
  void _updateOperationState(EnumAuthOperation operation,
      {bool? isLoading, String? errorMessage}) {
    _operationStates[operation] = (
      isLoading: isLoading ?? _operationStates[operation]!.isLoading,
      errorMessage: errorMessage
    );
    notifyListeners();
  }

  Future<void> _initCurrentUserCredentialManager() async {
    await _credentialManager.init();
    // * Cek apakah ada token yang tersimpan
    await _loadUserCredentialsFromCache();
  }

  Future<void> _loadUserCredentialsFromCache() async {
    final String? cachedAccessToken = _credentialManager.accessToken;
    final String? cachedRefreshToken = _credentialManager.refreshToken;

    if (cachedAccessToken != null && cachedRefreshToken != null) {
      // todo: Nanti ganti ke hive ini nyoba doang jangan pusingin
      _userCredential = UserCredentialModel(
        id: 'id',
        username: 'username',
        email: 'email',
        role: 'role',
        profilePicture: 'profilePicture',
        isVerified: true,
        isEmailVerified: true,
        createdAt: DateTime(2017, 9, 7, 17, 30),
        updatedAt: DateTime(2017, 9, 7, 17, 30),
        password: 'password',
        accessToken: cachedAccessToken,
        refreshToken: cachedRefreshToken,
      );
    }
    notifyListeners();
  }

  Future<void> signUp(SignUpModel payload) async {
    _updateOperationState(
      EnumAuthOperation.signUp,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _authServices.signUp(payload);

      _updateOperationState(
        EnumAuthOperation.signUp,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthOperation.signUp,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> signIn(SignInModel payload) async {
    _updateOperationState(
      EnumAuthOperation.signIn,
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
        EnumAuthOperation.signIn,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthOperation.signIn,
        isLoading: true,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    _updateOperationState(
      EnumAuthOperation.signOut,
      isLoading: true,
      errorMessage: null,
    );

    try {
      await _credentialManager.clearTokens();
      _userCredential = null;

      _updateOperationState(
        EnumAuthOperation.signOut,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      _updateOperationState(
        EnumAuthOperation.signOut,
        isLoading: false,
        errorMessage: e.toString(),
      );
      debugPrint(e.toString());
    }
  }

  // * Cek apakah user sudah login
  bool get isAuthenticated => _userCredential != null;
}
