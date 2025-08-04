import 'package:airbnb_clone_flutter/core/routing/app_router.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('liked_rooms');
  await Hive.openBox<dynamic>('liked_rooms');

  final container = ProviderContainer();
  final token = await SecureStorage().readToken();
  container.read(tokenProvider.notifier).state = token;

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Airbnb Clone',
      routerConfig: AppRouter().router,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
    );
  }
}
