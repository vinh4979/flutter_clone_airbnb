import 'package:airbnb_clone_flutter/core/utils/validators.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:airbnb_clone_flutter/providers/navigation_provider.dart';
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ Mật khẩu không khớp')));
      return;
    }

    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passController.text.trim();

    final success = await ref
        .read(authControllerProvider.notifier)
        .registerAndLogin(email, password);

    if (!mounted) return;

    setState(() => isLoading = false);

    if (success) {
      ref.read(bottomNavIndexProvider.notifier).state = 4;
      Navigator.of(context).pop(); // chỉ pop nếu đăng ký thành công
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
    final authState = ref.watch(authControllerProvider); // để bắt lỗi nếu có

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (authState is AsyncError)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '❌ ${(authState.error ?? 'Lỗi không xác định').toString()}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          Form(
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
        ],
      ),
    );
  }
}
