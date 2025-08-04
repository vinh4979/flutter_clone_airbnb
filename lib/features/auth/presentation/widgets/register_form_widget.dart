import 'package:airbnb_clone_flutter/core/utils/ui_helpers.dart';
import 'package:airbnb_clone_flutter/core/utils/validators.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:airbnb_clone_flutter/providers/navigation_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterFormWidget extends ConsumerStatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  ConsumerState<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends ConsumerState<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (passController.text.trim() != confirmController.text.trim()) {
      showErrorSnackbar(context, '❌ Mật khẩu không khớp');
      return;
    }

    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passController.text.trim();

    try {
      final success = await ref
          .read(authControllerProvider.notifier)
          .registerAndLogin(email, password);

      if (!mounted) return;

      if (success) {
        showSuccessSnackbar(context, '🎉 Tạo tài khoản thành công');
        ref.read(bottomNavIndexProvider.notifier).state = 4;
        Navigator.of(context).pop();
      } else {
        showErrorSnackbar(context, '❌ Đăng ký thất bại. Vui lòng thử lại.');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final errorMessage =
          data?['content'] ?? data?['message'] ?? 'Lỗi đăng ký';
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
    passController.dispose();
    confirmController.dispose();
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
              'Tạo tài khoản',
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
              controller: passController,
              label: "Mật Khẩu",
              hintText: "Nhập mật khẩu",
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(height: 16),
            CustomInputField(
              controller: confirmController,
              label: "Nhập lại mật khẩu",
              hintText: "Nhập lại mật khẩu",
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator:
                  (value) => Validators.validateConfirmPassword(
                    value,
                    passController.text,
                  ),
              prefixIcon: const Icon(Icons.lock_reset_outlined),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black, // 🎨 Màu app (đổi thành màu chủ đạo của bạn)
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.black.withOpacity(0.4),
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
                        "Đăng ký",
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
