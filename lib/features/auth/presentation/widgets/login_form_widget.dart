import 'package:airbnb_clone_flutter/core/di/providers.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/profile_provider.dart';
import 'package:airbnb_clone_flutter/providers/navigation_provider.dart';
import 'package:airbnb_clone_flutter/providers/token_check_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormWidget extends ConsumerStatefulWidget {
  const LoginFormWidget({super.key});

  @override
  ConsumerState<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final user = await ref.read(authRepositoryProvider).login(email, password);

    // ✅ Lưu token vào local
    await SecureStorage().saveToken(user.token);

    // ✅ Gán vào tokenProvider để widget khác thấy thay đổi
    ref.read(tokenProvider.notifier).state = user.token;

    // ❗ Invalidate nếu bạn đang dùng các provider khác phụ thuộc
    ref.invalidate(tokenCheckProvider);
    ref.invalidate(userProfileProvider);

    if (mounted) {
      ref.read(bottomNavIndexProvider.notifier).state = 4; // chuyển tab Profile
      Navigator.of(context).pop(); // đóng modal
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Đăng nhập',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Mật khẩu'),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          authState.when(
            data:
                (_) => ElevatedButton(
                  onPressed: handleLogin,
                  child: const Text('Đăng nhập'),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (e, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '❌ ${e.toString()}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: handleLogin,
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
