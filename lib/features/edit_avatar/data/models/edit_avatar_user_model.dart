import 'package:airbnb_clone_flutter/features/edit_avatar/domain/entities/user.dart';

class EditAvatarUserModel extends EditAvatarUser {
  EditAvatarUserModel({
    required int id,
    required String name,
    required String email,
    required String avatar,
  }) : super(id: id, name: name, email: email, avatar: avatar);

  factory EditAvatarUserModel.fromJson(Map<String, dynamic> json) {
    // Nếu API trả về full response có key 'content', cần bóc ra trước khi truyền
    final Map<String, dynamic> content = json['content'] ?? json;

    return EditAvatarUserModel(
      id: content['id'] ?? 0,
      name: content['name'] ?? '',
      email: content['email'] ?? '',
      avatar: content['avatar'] ?? '',
    );
  }

  EditAvatarUser toEntity() {
    return EditAvatarUser(id: id, name: name, email: email, avatar: avatar);
  }
}
