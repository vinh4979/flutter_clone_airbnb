import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/core/api/api_client_provider.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return UserRemoteDataSource(apiClient);
});

class UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSource(this._apiClient);

  Future<User> getUserById(int id) async {
    final response = await _apiClient.get('/users/$id');

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final content = data['content'] as Map<String, dynamic>;
      return User.fromJson(content);
    } else {
      throw Exception('Không thể lấy thông tin người dùng');
    }
  }
}
