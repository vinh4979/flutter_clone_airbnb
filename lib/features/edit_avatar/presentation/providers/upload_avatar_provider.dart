import 'dart:io';
import 'package:airbnb_clone_flutter/features/edit_avatar/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api/api_client_provider.dart';
import '../../data/datasources/edit_avatar_remote_datasource.dart';
import '../../data/repositories/edit_avatar_repository_impl.dart';
import '../../domain/usecases/upload_avatar_usecase.dart';
import '../../../profile_reactive/presentation/providers/user_profile_provider.dart';

/// Provider cho usecase upload avatar
final uploadAvatarUsecaseProvider = Provider<UploadAvatarUseCase>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final remote = EditAvatarRemoteDataSource(apiClient);
  final repo = EditAvatarRepositoryImpl(remote);
  return UploadAvatarUseCase(repo);
});

/// Provider dùng để gọi upload avatar (và invalidate user profile sau khi thành công)
final uploadAvatarControllerProvider =
    FutureProvider.family<EditAvatarUser, File>((ref, file) async {
      final usecase = ref.read(uploadAvatarUsecaseProvider);
      final user = await usecase(file);
      ref.invalidate(
        userProfileProvider,
      ); // vẫn dùng lại để cập nhật hồ sơ chính
      return user;
    });
