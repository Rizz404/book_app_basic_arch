import 'package:shared_preferences/shared_preferences.dart';

class UserCredentialManager {
  static final UserCredentialManager _instance =
      UserCredentialManager._internal();
  SharedPreferencesWithCache? _prefsWithCache;

  static const String idKey = 'id';
  static const String usernameKey = 'username';
  static const String emailKey = 'email';
  static const String profilePictureKey = 'profilePicture';
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';

  factory UserCredentialManager() => _instance;

  UserCredentialManager._internal();

  Future<void> init() async {
    _prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{
          idKey,
          usernameKey,
          emailKey,
          profilePictureKey,
          accessTokenKey,
          refreshTokenKey
        },
      ),
    );
  }

  String? get id => _prefsWithCache?.getString(idKey);
  String? get username => _prefsWithCache?.getString(usernameKey);
  String? get email => _prefsWithCache?.getString(emailKey);
  String? get profilePicture => _prefsWithCache?.getString(profilePictureKey);
  String? get accessToken => _prefsWithCache?.getString(accessTokenKey);
  String? get refreshToken => _prefsWithCache?.getString(refreshTokenKey);

  Future<void> saveTokens(String accessToken, {String? refreshToken}) async {
    await _prefsWithCache?.setString(accessTokenKey, accessToken);
    if (refreshToken != null) {
      await _prefsWithCache?.setString(refreshTokenKey, refreshToken);
    }
  }

  Future<void> saveCredentials({
    String? id,
    String? username,
    String? email,
    String? profilePicture,
    String? accessToken,
    String? refreshToken,
  }) async {
    if (id != null) {
      await _prefsWithCache?.setString(idKey, id);
    }

    if (username != null) {
      await _prefsWithCache?.setString(usernameKey, username);
    }

    if (email != null) {
      await _prefsWithCache?.setString(emailKey, email);
    }

    if (profilePicture != null) {
      await _prefsWithCache?.setString(profilePictureKey, profilePicture);
    }

    if (accessToken != null) {
      await _prefsWithCache?.setString(accessTokenKey, accessToken);
    }

    if (refreshToken != null) {
      await _prefsWithCache?.setString(refreshTokenKey, refreshToken);
    }
  }

  Future<void> clearTokens() async {
    await _prefsWithCache?.remove(idKey);
    await _prefsWithCache?.remove(usernameKey);
    await _prefsWithCache?.remove(emailKey);
    await _prefsWithCache?.remove(profilePictureKey);
    await _prefsWithCache?.remove(accessTokenKey);
    await _prefsWithCache?.remove(refreshTokenKey);
  }
}
