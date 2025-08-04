import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user.dart';
import '../models/edit_avatar_user_model.dart';

class EditAvatarRemoteDataSource {
  final ApiClient client;

  EditAvatarRemoteDataSource(this.client);

  Future<EditAvatarUser> uploadAvatar(File file) async {
    final userToken = await SecureStorage().readToken();

    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    print('🧪 MIME: $mimeType');

    if (![
      'image/jpeg',
      'image/jpg',
      'image/png',
      'image/gif',
    ].contains(mimeType)) {
      throw Exception('Định dạng ảnh không hợp lệ!');
    }

    final formData = FormData.fromMap({
      'formFile': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      ),
    });

    try {
      final response = await client.dio.post(
        '/users/upload-avatar',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'token': userToken,
            'tokenCybersoft':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJGbHV0dGVyIDAxIiwiSGV0SGFuU3RyaW5nIjoiMDkvMTEvMjAyNSIsIkhldEhhblRpbWUiOiIxNzYyNjQ2NDAwMDAwIiwibmJmIjoxNzM2MTIxNjAwLCJleHAiOjE3NjI4MTkyMDB9.We_FRRLkEJB271FX0Gcjbsfxsnl5YAym7uhkcKXulSQ',
          },
        ),
      );

      if (response.data['content'] == null) {
        throw Exception('Server không trả về thông tin người dùng');
      }

      return EditAvatarUserModel.fromJson(response.data['content']).toEntity();
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          'Lỗi kết nối server: ${e.message ?? e.toString()}';
      throw Exception(message);
    } catch (e) {
      throw Exception('Lỗi không xác định: ${e.toString()}');
    }
  }
}
