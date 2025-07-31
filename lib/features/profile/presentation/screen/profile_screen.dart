import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/core/utils/app_logger.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/profile_provider.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/refresh_profile_provider.dart';
import 'package:airbnb_clone_flutter/shared/widgets/debug_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLogger.info("🔄 ProfileScreen build");

    // ✅ Lắng nghe refresh flag để invalidate provider
    ref.listen<bool>(refreshProfileProvider, (previous, next) {
      if (next == true) {
        AppLogger.info(
          "🟢 refreshProfileProvider = true, invalidating userProfileProvider",
        );
        ref.invalidate(userProfileProvider);
        ref.read(refreshProfileProvider.notifier).state = false;
      }
    });

    // ✅ Watch user profile
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ'), centerTitle: true),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (user) {
          final name = user.name;
          final email = user.email;
          final avatarUrl = user.avatar;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              // ==== Header ====
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                    child:
                        avatarUrl.isEmpty
                            ? Text(
                              name.isNotEmpty ? name[0].toUpperCase() : '?',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(),

              _ProfileTile(
                icon: Icons.favorite_border,
                title: 'Danh sách yêu thích',
                onTap: () {},
              ),
              _ProfileTile(
                icon: Icons.history,
                title: 'Lịch sử đặt phòng',
                onTap: () {},
              ),
              _ProfileTile(
                icon: Icons.home_outlined,
                title: 'Trở thành chủ nhà',
                onTap: () {},
              ),
              _ProfileTile(
                icon: Icons.settings_outlined,
                title: 'Cài đặt tài khoản',
                onTap: () {},
              ),
              _ProfileTile(
                icon: Icons.language,
                title: 'Ngôn ngữ & Tiền tệ',
                onTap: () {},
              ),

              const Divider(),

              _ProfileTile(
                icon: Icons.help_outline,
                title: 'Trung tâm trợ giúp',
                onTap: () {},
              ),
              _ProfileTile(
                icon: Icons.logout,
                title: 'Đăng xuất',
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Xác nhận đăng xuất'),
                          content: const Text(
                            'Bạn có chắc chắn muốn đăng xuất?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Huỷ'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Đăng xuất'),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    final container = ProviderScope.containerOf(context);

                    await SecureStorage().clear();
                    container.invalidate(userProfileProvider);

                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  }
                },
              ),

              if (!bool.fromEnvironment('dart.vm.product')) ...[
                const Divider(),
                _ProfileTile(
                  icon: Icons.bug_report_outlined,
                  title: 'Debug Menu',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DebugMenuScreen(),
                      ),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
