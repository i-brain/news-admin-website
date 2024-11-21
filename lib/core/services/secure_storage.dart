import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/preferences_keys.dart';

class SecureStorageService {
  //{
  //Configuration
  SecureStorageService() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
      webOptions: const WebOptions(),
    );
  }

  late final FlutterSecureStorage _secureStorage;
  IOSOptions _getIOSOptions() => const IOSOptions();
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  //Configuration
  //}

  Future<String?> get token => _secureStorage.read(key: PreferencesKeys.token);

  Future<void> saveToken(String token) {
    return _secureStorage.write(key: PreferencesKeys.token, value: token);
  }

  Future<void> removeToken() {
    return _secureStorage.delete(key: PreferencesKeys.token);
  }
}
