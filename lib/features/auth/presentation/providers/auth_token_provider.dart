import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Token provider – dùng để lưu token khi app đang chạy
final tokenProvider = StateProvider<String?>((ref) => null);

/// isLoggedIn = true nếu có token
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(tokenProvider) != null;
});

/// Hàm khởi tạo: đọc token từ SecureStorage, lưu vào provider
Future<void> initAuthState(WidgetRef ref) async {
  final token = await SecureStorage().readToken();
  ref.read(tokenProvider.notifier).state = token;
}
