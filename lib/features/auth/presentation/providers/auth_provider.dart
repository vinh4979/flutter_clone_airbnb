import 'package:airbnb_clone_flutter/core/di/providers.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<String?>>(
      (ref) => AuthController(ref),
    );

class AuthController extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;

  AuthController(this.ref) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      final token = user.token;

      await SecureStorage().saveToken(token);

      state = AsyncValue.data(token);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).register(email, password);
      state = const AsyncValue.data(null); // <-- thêm dòng này
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
