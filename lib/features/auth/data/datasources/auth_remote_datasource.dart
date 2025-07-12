import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  // feature login
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/signin',
        data: {'email': email, 'password': password},
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data.toString() ?? 'Unknown error',
      ); // custom lỗi
    }
  }

  // Register
  Future<RegisterModel> register(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/signup',
        data: {'email': email, 'password': password},
      );

      return RegisterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data.toString() ?? 'Unknown error',
      ); // custom lỗi
    }
  }
}
