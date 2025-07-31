import 'dart:io';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import '../../domain/entities/update_user_info.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../../data/models/update_user_dto.dart';
import '../../data/datasources/edit_profile_remote_datasource.dart';
import '../../data/datasources/upload_avatar_datasource.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDatasource remoteDatasource;
  final UploadAvatarDatasource avatarDatasource;

  EditProfileRepositoryImpl({
    required this.remoteDatasource,
    required this.avatarDatasource,
  });

  @override
  Future<void> updateUserInfo(int id, UpdateUserInfo info) {
    final dto = UpdateUserDto.fromEntity(info);
    return remoteDatasource.updateUserInfo(id, dto);
  }

  @override
  Future<User> uploadAvatar(File imageFile) {
    return avatarDatasource.uploadAvatar(imageFile);
  }
}
