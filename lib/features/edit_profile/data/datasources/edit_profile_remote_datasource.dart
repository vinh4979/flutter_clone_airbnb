import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/core/api/api_client_provider.dart';
import '../models/update_user_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileRemoteDatasourceProvider =
    Provider<EditProfileRemoteDatasource>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return EditProfileRemoteDatasource(apiClient);
    });

class EditProfileRemoteDatasource {
  final ApiClient _apiClient;

  EditProfileRemoteDatasource(this._apiClient);

  Future<void> updateUserInfo(int id, UpdateUserDto dto) async {
    await _apiClient.put('/users/$id', data: dto.toJson());
  }
}
