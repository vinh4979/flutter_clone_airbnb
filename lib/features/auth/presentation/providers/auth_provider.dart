import 'package:airbnb_clone_flutter/core/di/providers.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/profile_provider.dart';
import 'package:airbnb_clone_flutter/providers/liked_rooms_provider.dart';
import 'package:airbnb_clone_flutter/providers/token_check_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<String?>>(
      (ref) => AuthController(ref),
    );

class AuthController extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;

  AuthController(this.ref) : super(const AsyncValue.data(null));

  // Check token từ local khi app khởi động
  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    try {
      final token = await SecureStorage().readToken();
      ref.read(tokenProvider.notifier).state = token; // ✅ quan trọng
      state = AsyncValue.data(token);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Đăng nhập
  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      final token = user.token;

      await SecureStorage().saveToken(token);
      ref.read(tokenProvider.notifier).state = token;
      ref.invalidate(userProfileProvider);
      state = AsyncValue.data(token);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  // Đăng ký + tự login
  Future<bool> registerAndLogin(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).register(email, password);
    } catch (e, st) {
      state = AsyncValue.error("Đăng ký thất bại: ${e.toString()}", st);
      return false;
    }

    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      final token = user.token;

      await SecureStorage().saveToken(token);
      ref.read(tokenProvider.notifier).state = token;
      ref.invalidate(userProfileProvider);
      state = AsyncValue.data(token);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(
        "Đăng nhập sau đăng ký thất bại: ${e.toString()}",
        st,
      );
      return false;
    }
  }

  // Logout: xoá local + reset state
  Future<void> logout() async {
    final storage = SecureStorage();
    await storage.deleteToken(); // Xoá token

    await Hive.box<dynamic>(
      'liked_rooms',
    ).clear(); // 🧹 Xoá danh sách yêu thích

    ref.invalidate(tokenProvider); // ✅ Reset token
    ref.invalidate(tokenCheckProvider); // ✅ Reset check login
    ref.invalidate(userProfileProvider); // ✅ Reset user info
    ref.invalidate(likedRoomsProvider); // ✅ Reset likedRooms local
  }

  //Get token
  String? get token => state.valueOrNull;
}
