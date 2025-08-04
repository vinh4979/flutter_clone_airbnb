import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 1));

    // Gọi provider kiểm tra token
    await ref.read(authControllerProvider.notifier).checkAuthStatus();

    final token = ref.read(authControllerProvider).valueOrNull;

    if (!mounted) return;

    if (token != null) {
      context.go('/main');
    } else {
      context.go('/main'); // vẫn vào main layout
      // Delay nhỏ rồi show modal login
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        showAppModal(context, AppModalType.auth); // login/register
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // hiệu ứng splash
      ),
    );
  }
}
