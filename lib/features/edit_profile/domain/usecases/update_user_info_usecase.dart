import '../entities/update_user_info.dart';
import '../repositories/edit_profile_repository.dart';

class UpdateUserInfoUsecase {
  final EditProfileRepository repository;

  UpdateUserInfoUsecase(this.repository);

  Future<void> call(int id, UpdateUserInfo info) {
    return repository.updateUserInfo(id, info);
  }
}
