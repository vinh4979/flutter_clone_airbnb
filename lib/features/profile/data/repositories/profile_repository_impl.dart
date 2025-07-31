import 'package:airbnb_clone_flutter/features/profile/domain/entities/user_profile.dart';
import 'package:airbnb_clone_flutter/features/profile/domain/repositories/profile_repository.dart';
import 'package:airbnb_clone_flutter/features/profile/data/datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserProfile> getUserProfile(int id) async {
    final model = await remoteDataSource.getUserProfile(id);
    return UserProfile(
      id: model.id,
      name: model.name,
      email: model.email,
      phone: model.phone,
      birthday: model.birthday,
      avatar: model.avatar,
      gender: model.gender,
      role: model.role,
    );
  }
}
