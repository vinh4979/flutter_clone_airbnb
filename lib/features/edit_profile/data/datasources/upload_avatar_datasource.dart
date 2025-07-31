import 'dart:io';
import 'package:airbnb_clone_flutter/core/api/api_client_provider.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadAvatarDatasourceProvider = Provider<UploadAvatarDatasource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final storage = ref.read(secureStorageProvider);
  return UploadAvatarDatasource(apiClient.dio, storage);
});

class UploadAvatarDatasource {
  final Dio _dio;
  final SecureStorage _storage;

  UploadAvatarDatasource(this._dio, this._storage);

  Future<User> uploadAvatar(File imageFile) async {
    final token = await _storage.readToken();
    final formData = FormData.fromMap({
      'formFile': await MultipartFile.fromFile(imageFile.path),
    });

    final response = await _dio.post(
      '/users/upload-avatar',
      data: formData,
      options: Options(
        headers: {
          'token': token, // khác tokenCybersoft
        },
      ),
    );

    return User.fromJson(response.data['content']);
  }
}
