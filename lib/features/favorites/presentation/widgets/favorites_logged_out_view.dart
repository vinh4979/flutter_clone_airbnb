import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';

class FavoritesLoggedOutView extends StatelessWidget {
  const FavoritesLoggedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yêu thích')),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đăng nhập để xem danh sách Yêu thích của bạn',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Bạn có thể tạo, xem hoặc chỉnh sửa danh sách Yêu thích sau khi đăng nhập.',
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
