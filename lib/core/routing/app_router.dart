import 'package:airbnb_clone_flutter/shared/layouts/main_layout.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) {
          return const MainLayout();
          // return const AuthLayout(child: LoginScreen());
        },
      ),
    ],
  );
}
