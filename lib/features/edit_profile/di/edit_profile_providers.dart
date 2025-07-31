import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/edit_profile_remote_datasource.dart';
import '../data/datasources/upload_avatar_datasource.dart';
import '../data/repositories/edit_profile_repository_impl.dart';
import '../domain/repositories/edit_profile_repository.dart';
import '../domain/usecases/update_user_info_usecase.dart';
import '../domain/usecases/upload_avatar_usecase.dart';

/// 📦 Repository
final editProfileRepositoryProvider = Provider<EditProfileRepository>((ref) {
  final remote = ref.read(editProfileRemoteDatasourceProvider);
  final avatar = ref.read(uploadAvatarDatasourceProvider);
  return EditProfileRepositoryImpl(
    remoteDatasource: remote,
    avatarDatasource: avatar,
  );
});

/// ✅ Usecase: Update User Info
final updateUserInfoUsecaseProvider = Provider<UpdateUserInfoUsecase>((ref) {
  final repo = ref.read(editProfileRepositoryProvider);
  return UpdateUserInfoUsecase(repo);
});

/// ✅ Usecase: Upload Avatar
final uploadAvatarUsecaseProvider = Provider<UploadAvatarUsecase>((ref) {
  final repo = ref.read(editProfileRepositoryProvider);
  return UploadAvatarUsecase(repo);
});
