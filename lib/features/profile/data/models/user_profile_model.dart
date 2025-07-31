import 'package:airbnb_clone_flutter/features/profile/domain/entities/user_profile.dart';

class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final String avatar;
  final bool gender;
  final String role;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.avatar,
    required this.gender,
    required this.role,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final content = json['content'];
    return UserProfileModel(
      id: content['id'],
      name: content['name'],
      email: content['email'],
      phone: content['phone'],
      birthday: content['birthday'],
      avatar: content['avatar'],
      gender: content['gender'],
      role: content['role'],
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      name: name,
      email: email,
      phone: phone,
      birthday: birthday,
      avatar: avatar,
      gender: gender,
      role: role,
    );
  }
}
