import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/theme_provider.dart';

class SwitchThemeModeButton extends ConsumerWidget {
  const SwitchThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return SwitchListTile(
      title: const Text('Dark Mode'),
      secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
      value: isDarkMode,
      onChanged: (_) {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
    );
  }
}
