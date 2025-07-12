import 'package:airbnb_clone_flutter/features/profile/presentation/widgets/switch_theme_mode_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          SwitchThemeModeButton(),
          Divider(),

          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            trailing: Icon(Icons.chevron_right),
          ),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            trailing: Icon(Icons.chevron_right),
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
