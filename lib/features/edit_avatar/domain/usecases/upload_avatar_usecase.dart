import 'dart:io';
import 'package:airbnb_clone_flutter/features/edit_avatar/domain/entities/user.dart';

import '../repositories/edit_avatar_repository.dart';

class UploadAvatarUseCase {
  final EditAvatarRepository repository;

  UploadAvatarUseCase(this.repository);

  Future<EditAvatarUser> call(File file) {
    return repository.uploadAvatar(file);
  }
}
