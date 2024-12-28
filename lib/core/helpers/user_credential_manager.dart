import 'package:book_app_basic_arch/features/auth/model/local/user_credential_model.dart';
import 'package:hive/hive.dart';

class UserCredentialManager {
  static final UserCredentialManager _instance =
      UserCredentialManager._internal();
  late Box<UserCredentialModel> _userCredentialBox;

  factory UserCredentialManager() => _instance;

  UserCredentialManager._internal();

  Future<void> init() async {
    _userCredentialBox =
        await Hive.openBox<UserCredentialModel>('userCredentials');
  }

  Future<void> saveUserCredential(UserCredentialModel user) async {
    await _userCredentialBox.put('user', user);
  }

  UserCredentialModel? getUserCredential() {
    return _userCredentialBox.get('user');
  }

  Future<void> clearUserCredential() async {
    await _userCredentialBox.delete('user');
  }
}
