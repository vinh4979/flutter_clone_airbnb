import 'package:dio/dio.dart';
import '../models/user_profile_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<UserProfileModel> getUserProfile(int userId) async {
    final response = await dio.get('/users/$userId');
    return UserProfileModel.fromJson(response.data);
  }
}
