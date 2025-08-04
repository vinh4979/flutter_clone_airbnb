import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecureStorage {
  static const _tokenKey = 'token';
  final _secure = const FlutterSecureStorage();

  Future<void> saveToken(String token) =>
      _secure.write(key: _tokenKey, value: token);

  Future<String?> readToken() => _secure.read(key: _tokenKey);

  Future<void> deleteToken() => _secure.delete(key: _tokenKey);

  Future<void> clear() => _secure.deleteAll();
}

// ✅ Provider để inject qua Riverpod
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});
