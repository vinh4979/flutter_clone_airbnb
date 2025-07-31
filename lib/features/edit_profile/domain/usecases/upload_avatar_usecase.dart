import 'dart:io';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';

import '../repositories/edit_profile_repository.dart';

class UploadAvatarUsecase {
  final EditProfileRepository repository;

  UploadAvatarUsecase(this.repository);

  Future<User> call(File imageFile) {
    return repository.uploadAvatar(imageFile);
  }
}
