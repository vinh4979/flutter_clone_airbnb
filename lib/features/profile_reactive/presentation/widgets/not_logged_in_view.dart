import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';

class LoggedOutProfileView extends StatelessWidget {
  const LoggedOutProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Hồ sơ',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Đăng nhập và bắt đầu lập kế hoạch cho chuyến đi tiếp theo của bạn.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showAppModal(context, AppModalType.auth);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Đăng nhập hoặc đăng ký'),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Cài đặt tài khoản'),
            onTap: () {
              // TODO: Navigate to account settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Nhận trợ giúp'),
            onTap: () {
              // TODO: Open help page
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text('Pháp lý'),
            onTap: () {
              // TODO: Open legal page
            },
          ),
        ],
      ),
    );
  }
}
