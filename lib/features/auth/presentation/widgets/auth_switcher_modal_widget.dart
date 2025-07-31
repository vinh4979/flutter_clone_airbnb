import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/login_form_widget.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';

class AuthSwitcherModalWidget extends StatefulWidget {
  const AuthSwitcherModalWidget({super.key});

  @override
  State<AuthSwitcherModalWidget> createState() =>
      _AuthSwitcherModalWidgetState();
}

class _AuthSwitcherModalWidgetState extends State<AuthSwitcherModalWidget> {
  bool showLogin = true;

  void toggleForm() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showLogin ? 'Đăng nhập' : 'Đăng ký'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    showLogin
                        ? const LoginFormWidget(key: ValueKey('login'))
                        : const RegisterFormWidget(key: ValueKey('register')),
              ),
            ),
            TextButton(
              onPressed: toggleForm,
              child: Text(
                showLogin
                    ? 'Chưa có tài khoản? Đăng ký'
                    : 'Đã có tài khoản? Đăng nhập',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
