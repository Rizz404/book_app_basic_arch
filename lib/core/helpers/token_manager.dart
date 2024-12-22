import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  SharedPreferencesWithCache? _prefsWithCache;

  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';

  factory TokenManager() => _instance;

  TokenManager._internal();

  Future<void> init() async {
    _prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{accessTokenKey, refreshTokenKey},
      ),
    );
  }

  String? get accessToken => _prefsWithCache?.getString(accessTokenKey);
  String? get refreshToken => _prefsWithCache?.getString(refreshTokenKey);

  Future<void> saveTokens(String accessToken, {String? refreshToken}) async {
    await _prefsWithCache?.setString(accessTokenKey, accessToken);
    if (refreshToken != null) {
      await _prefsWithCache?.setString(refreshTokenKey, refreshToken);
    }
  }

  Future<void> clearTokens() async {
    await _prefsWithCache?.remove(accessTokenKey);
    await _prefsWithCache?.remove(refreshTokenKey);
  }
}
