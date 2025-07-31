import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/core/utils/app_logger.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/providers/profile_provider.dart';
import 'package:airbnb_clone_flutter/providers/is_logged_in_provider.dart';
import 'package:airbnb_clone_flutter/providers/refresh_profile_provider.dart';
import 'package:airbnb_clone_flutter/providers/token_check_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClearTokenButton extends ConsumerWidget {
  const ClearTokenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        await SecureStorage().clear();
        ref.read(refreshProfileProvider.notifier).state = true;
        ref.invalidate(tokenCheckProvider);
        ref.invalidate(userProfileProvider); // xoá dữ liệu người dùng cũ
        ref.invalidate(isLoggedInProvider);
        // ref.read(refreshProfileProvider.notifier).state = true;

        AppLogger.info("🧹 Đã xoá token và yêu cầu refresh profile");

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("🧹 Đã xoá token")));
        }
      },
      child: const Text("🧹 Clear All Token"),
    );
  }
}
