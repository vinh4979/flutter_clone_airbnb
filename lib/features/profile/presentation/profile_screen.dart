import 'package:airbnb_clone_flutter/features/profile/presentation/settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Chuyển sang màn Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help Center'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Xử lý khi nhấn Help Center
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Xử lý khi nhấn About
            },
          ),
        ],
      ),
    );
  }
}
