import 'package:airbnb_clone_flutter/features/auth/presentation/screens/splash_screen.dart';
import 'package:airbnb_clone_flutter/shared/layouts/main_layout.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: 'main',
        path: '/main',
        builder: (context, state) => const MainLayout(),
      ),
    ],
  );
}
