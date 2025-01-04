import 'dart:convert';

import 'package:book_app_basic_arch/features/auth/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCredentialManager {
  static final UserCredentialManager _instance =
      UserCredentialManager._internal();
  SharedPreferencesWithCache? _prefsWithCache;
  bool _isInitialized = false;

  static const String _credentialKey = 'user_credential';

  factory UserCredentialManager() => _instance;
  UserCredentialManager._internal();

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (!_isInitialized) {
      _prefsWithCache = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{
            _credentialKey,
          },
        ),
      );
      _isInitialized = true;
    }
  }

  UserCredentialModel? get credentials {
    final jsonStr = _prefsWithCache?.getString(_credentialKey);
    if (jsonStr == null) return null;
    return UserCredentialModel.fromJson(jsonDecode(jsonStr));
  }

  String? get accessToken => credentials?.accessToken;
  String? get refreshToken => credentials?.refreshToken;

  Future<void> saveCredentials(UserCredentialModel credentials) async {
    if (!_isInitialized) await init();
    await _prefsWithCache?.setString(
      _credentialKey,
      jsonEncode(credentials.toJson()),
    );
  }

  Future<void> clearCredentials() async {
    if (!_isInitialized) await init();
    await _prefsWithCache?.remove(_credentialKey);
  }
}
