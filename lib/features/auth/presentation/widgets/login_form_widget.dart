import 'package:airbnb_clone_flutter/core/di/providers.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/core/utils/ui_helpers.dart';
import 'package:airbnb_clone_flutter/core/utils/validators.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/profile_provider.dart';
import 'package:airbnb_clone_flutter/providers/navigation_provider.dart';
import 'package:airbnb_clone_flutter/providers/token_check_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormWidget extends ConsumerStatefulWidget {
  const LoginFormWidget({super.key});

  @override
  ConsumerState<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() => isLoading = true);

    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);

      await SecureStorage().saveToken(user.token);
      ref.read(tokenProvider.notifier).state = user.token;

      ref.invalidate(tokenCheckProvider);
      ref.invalidate(userProfileProvider);

      if (!mounted) return;

      showSuccessSnackbar(context, '✅ Đăng nhập thành công');
      ref.read(bottomNavIndexProvider.notifier).state = 4;
      Navigator.of(context).pop();
    } on DioException catch (e) {
      final data = e.response?.data;
      final errorMessage =
          data?['content'] ?? data?['message'] ?? 'Lỗi đăng nhập';
      if (mounted) showErrorSnackbar(context, '❌ $errorMessage');
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, '❌ Lỗi không xác định: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Đăng nhập',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: emailController,
              label: "Email",
              hintText: "example@gmail.com",
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: passwordController,
              label: "Mật khẩu",
              hintText: "Nhập mật khẩu",
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.black.withValues(alpha: 0.4),
                disabledForegroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child:
                  isLoading
                      ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
