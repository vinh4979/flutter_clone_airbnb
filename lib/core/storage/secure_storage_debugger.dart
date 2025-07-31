import 'package:airbnb_clone_flutter/core/utils/app_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDebugger {
  static final _storage = const FlutterSecureStorage();

  static Future<void> printAllKeysAndValues() async {
    final allValues = await _storage.readAll();
    if (allValues.isEmpty) {
      AppLogger.info('🔍 Không có dữ liệu nào trong SecureStorage');
      return;
    }

    AppLogger.info('📦 Dữ liệu trong SecureStorage:');
    for (final entry in allValues.entries) {
      AppLogger.info('🔑 ${entry.key}: ${entry.value}');
    }
  }
}
