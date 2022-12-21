import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageData {
  static const _storage = FlutterSecureStorage();

  // Keys
  static const _keyUsername = 'username';
  static const _keyUserID = 'userID';

  // Methods
  static Future setUserName(String username) async => await _storage.write(key: _keyUsername, value: username);
  static Future<String?> getUsername() async => _storage.read(key: _keyUsername);

  static Future setUserID(String userID) async => await _storage.write(key: _keyUserID, value: userID);
  static Future<String?> getUserID() async => await _storage.read(key: _keyUserID);

}