import 'package:airbnb_clone_flutter/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  // Đăng nhập
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/signin',
        data: {'email': email, 'password': password},
      );

      AppLogger.prettyJson(response.data, tag: 'Login response');

      final content = response.data['content'];
      return UserModel.fromJson(content); // Chuyển content → model
    } on DioException catch (e) {
      final message =
          e.response?.data['content'] ??
          e.response?.data['message'] ??
          'Đăng nhập thất bại';
      throw Exception(message);
    }
  }

  // Đăng ký
  Future<void> register(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/signup',
        data: {'email': email, 'password': password},
      );

      AppLogger.prettyJson(response.data, tag: 'Register response');
    } on DioException catch (e) {
      final message =
          e.response?.data['content'] ??
          e.response?.data['message'] ??
          'Đăng ký thất bại';
      throw Exception(message);
    }
  }
}
