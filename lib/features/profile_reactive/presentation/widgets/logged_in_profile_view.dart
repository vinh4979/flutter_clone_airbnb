import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/presentation/providers/user_profile_provider.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggedInProfileView extends ConsumerWidget {
  final String token;
  const LoggedInProfileView({super.key, required this.token});

  String _getInitials(User user) {
    final name = user.name?.trim();
    if (name != null && name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }

    final email = user.email?.trim();
    if (email != null && email.isNotEmpty) {
      return email.substring(0, 1).toUpperCase();
    }

    return '?';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi: $err')),
      data: (user) {
        return Scaffold(
          appBar: AppBar(title: const Text('Hồ sơ')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // 🧑‍💼 Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        user.avatar != null && user.avatar!.isNotEmpty
                            ? NetworkImage(user.avatar!)
                            : null,
                    child:
                        (user.avatar == null || user.avatar!.isEmpty)
                            ? Text(
                              _getInitials(user),
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 🔧 Tài khoản
              _buildSectionTitle('Tài khoản'),
              _buildTile(Icons.edit, 'Chỉnh sửa hồ sơ', () {
                showAppModal(context, AppModalType.editProfile);
              }),
              _buildTile(Icons.lock_outline, 'Đổi mật khẩu', () {}),
              _buildTile(Icons.house, 'Trở thành chủ nhà', () {}),
              const Divider(height: 32),

              // 📘 Hoạt động
              _buildSectionTitle('Hoạt động'),
              _buildTile(Icons.history, 'Lịch sử đặt phòng', () {}),
              _buildTile(Icons.favorite_border, 'Danh sách yêu thích', () {}),
              const Divider(height: 32),

              // 🚪 Khác
              _buildSectionTitle('Khác'),
              _buildTile(
                Icons.logout,
                'Đăng xuất',
                () => ref.read(authControllerProvider.notifier).logout(),
                color: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }

  // 🛠️ Helper: Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 🛠️ Helper: Tile
  Widget _buildTile(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, color: color ?? Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      visualDensity: const VisualDensity(vertical: -2), // Gọn chiều cao
    );
  }
}
