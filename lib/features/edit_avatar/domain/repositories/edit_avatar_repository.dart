import 'dart:io';

import 'package:airbnb_clone_flutter/features/edit_avatar/domain/entities/user.dart';

abstract class EditAvatarRepository {
  Future<EditAvatarUser> uploadAvatar(File file);
}
