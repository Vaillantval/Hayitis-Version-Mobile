// lib/core/storage/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _accessToken  = 'access_token';
  static const _refreshToken = 'refresh_token';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await Future.wait([
      _storage.write(key: _accessToken, value: access),
      _storage.write(key: _refreshToken, value: refresh),
    ]);
  }

  static Future<String?> getAccessToken() =>
      _storage.read(key: _accessToken);

  static Future<String?> getRefreshToken() =>
      _storage.read(key: _refreshToken);

  static Future<void> updateAccessToken(String token) =>
      _storage.write(key: _accessToken, value: token);

  static Future<void> clearAll() => _storage.deleteAll();
}
