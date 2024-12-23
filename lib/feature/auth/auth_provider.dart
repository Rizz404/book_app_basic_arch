import 'package:book_app_basic_arch/core/helpers/token_manager.dart';
import 'package:book_app_basic_arch/core/shared/type/operation_state.dart';
import 'package:book_app_basic_arch/feature/auth/auth_services.dart';
import 'package:book_app_basic_arch/feature/auth/enum_auth_operation.dart';
import 'package:book_app_basic_arch/feature/auth/model/auth_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  final TokenManager _tokenManager = TokenManager();

  // * Langsung init jadinya
  AuthProvider() {
    _initTokenManager();
  }

  UserCredentialModel? _userCredential;
  UserCredentialModel? get userCredential => _userCredential;

  // * Getters untuk tokens melalui TokenManager
  String? get accessToken => _tokenManager.accessToken;
  String? get refreshToken => _tokenManager.refreshToken;

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

  Future<void> _initTokenManager() async {
    await _tokenManager.init();
    // * Cek apakah ada token yang tersimpan
    await _loadUserCredentialsFromCache();
  }

  Future<void> _loadUserCredentialsFromCache() async {
    final String? cachedAccessToken = _tokenManager.accessToken;
    final String? cachedRefreshToken = _tokenManager.refreshToken;

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
    _updateOperationState(EnumAuthOperation.signUp, isLoading: true);
    notifyListeners();

    try {
      await _authServices.signUp(payload);
    } catch (e) {
      _updateOperationState(EnumAuthOperation.signUp,
          errorMessage: e.toString());
    } finally {
      _updateOperationState(EnumAuthOperation.signUp, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> signIn(SignInModel payload) async {
    _updateOperationState(EnumAuthOperation.signIn, isLoading: true);
    notifyListeners();

    try {
      final response = await _authServices.signIn(payload);

      _userCredential = response.data;

      if (_userCredential != null) {
        await _tokenManager.saveTokens(
          _userCredential!.accessToken,
          refreshToken: _userCredential?.refreshToken,
        );
      }
    } catch (e) {
      _updateOperationState(EnumAuthOperation.signIn,
          errorMessage: e.toString());
      debugPrint(e.toString());
    } finally {
      _updateOperationState(EnumAuthOperation.signIn, isLoading: false);
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _updateOperationState(EnumAuthOperation.signOut, isLoading: true);
    notifyListeners();

    try {
      await _tokenManager.clearTokens();
      _userCredential = null;
    } catch (e) {
      _updateOperationState(EnumAuthOperation.signOut,
          errorMessage: e.toString());
      debugPrint(e.toString());
    } finally {
      _updateOperationState(EnumAuthOperation.signOut, isLoading: false);
      notifyListeners();
    }
  }

  // * Cek apakah user sudah login
  bool get isAuthenticated => _userCredential != null;
}
