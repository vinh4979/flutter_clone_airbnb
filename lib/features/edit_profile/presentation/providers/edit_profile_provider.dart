import 'dart:io';
import 'package:airbnb_clone_flutter/features/edit_profile/di/edit_profile_providers.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/update_user_info.dart';

/// 📌 Provider gửi thông tin cập nhật hồ sơ
final updateUserInfoProvider = FutureProvider.family
    .autoDispose<void, (int userId, UpdateUserInfo info)>((ref, params) async {
      final usecase = ref.read(updateUserInfoUsecaseProvider);
      final (userId, info) = params;
      await usecase(userId, info);
    });

/// 📌 Provider upload avatar
final uploadAvatarProvider = FutureProvider.autoDispose.family<User, File>((
  ref,
  file,
) async {
  final usecase = ref.read(uploadAvatarUsecaseProvider);
  final user = await usecase(file);
  return user;
});
