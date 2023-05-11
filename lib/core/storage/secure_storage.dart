import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/constants/constants.dart';

class SecureStorage {
  static final SecureStorage _singleton = SecureStorage._internal();
  FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory SecureStorage() {
    return _singleton;
  }

  SecureStorage._internal() {
    _storage = const FlutterSecureStorage();
  }

  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<String?> getAccessToken() async {
    return await  get(CONST.accessToken);
  }

  Future<void> saveAccessToken(String value) async {
    await save(CONST.accessToken, value);
  }

  Future<void> removeAccessToken() async {
    await save(CONST.accessToken, '');
  }

  Future<void> saveUserId(int userId) async {
    await save(CONST.userId, userId.toString());
  }

  Future<String?> getUserId() async {
    return await get(CONST.userId);
  }

  Future<void> removeUserId() async {
    await save(CONST.userId, '');
  }

  register(FlutterSecureStorage secureStorage) {
    _storage = secureStorage;
  }
}

final secureStorage = SecureStorage();
