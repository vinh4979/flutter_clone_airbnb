import 'package:airbnb_clone_flutter/core/utils/validators.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true),
);

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      final email = emailController.text.trim();
      final password = passController.text.trim();
      final confirmPassword = confirmController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Mật khẩu không khớp')));
        setState(() => isLoading = false);
        return;
      }

      _logger.i('Register info: Email: $email, Password: $password');

      try {
        await ref
            .read(authControllerProvider.notifier)
            .register(email, password);

        if (mounted) {
          setState(() => isLoading = false);
          Navigator.pop(context); // hoặc điều hướng sang trang chính
        }
      } catch (e, stackTrace) {
        _logger.e("Register failed", error: e, stackTrace: stackTrace);
        if (mounted) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng ký thất bại: ${e.toString()}')),
          );
        }
      }
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
    return Scaffold(
      appBar: AppBar(title: const Text("Tạo tài khoản")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text("Đăng ký"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
