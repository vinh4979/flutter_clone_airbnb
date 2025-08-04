import 'dart:io';

import 'package:airbnb_clone_flutter/features/edit_avatar/domain/entities/user.dart';

import '../../domain/repositories/edit_avatar_repository.dart';
import '../datasources/edit_avatar_remote_datasource.dart';

class EditAvatarRepositoryImpl implements EditAvatarRepository {
  final EditAvatarRemoteDataSource remote;

  EditAvatarRepositoryImpl(this.remote);

  @override
  Future<EditAvatarUser> uploadAvatar(File file) {
    return remote.uploadAvatar(file);
  }
}
