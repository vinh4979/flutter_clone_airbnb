// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _saveThemeToPrefs(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    _saveThemeToPrefs(!isDark);
  }
}
