import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';

class InboxLoggedOutView extends StatelessWidget {
  const InboxLoggedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hộp thư')),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đăng nhập để xem tin nhắn',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sau khi đăng nhập, bạn sẽ tìm thấy tin nhắn từ chủ nhà/người tổ chức ở đây.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  showAppModal(context, AppModalType.auth);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
