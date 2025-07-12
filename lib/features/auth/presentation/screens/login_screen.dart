import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void handleLogin() async {
      final email = emailController.text.trim();
      final password = passwordController.text;
      await ref.read(authControllerProvider.notifier).login(email, password);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
          data: (user) {
            if (user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🎉 Đăng nhập thành công')),
                );
              });
            }

            return ElevatedButton(
              onPressed: handleLogin,
              child: const Text('Đăng nhập'),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (e, _) => Column(
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
    );
  }
}
