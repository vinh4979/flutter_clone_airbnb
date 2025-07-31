import 'dart:io';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';

import '../entities/update_user_info.dart';

abstract class EditProfileRepository {
  Future<void> updateUserInfo(int id, UpdateUserInfo info);
  Future<User> uploadAvatar(File imageFile);
}
