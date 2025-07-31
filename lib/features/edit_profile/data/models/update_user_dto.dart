import '../../domain/entities/update_user_info.dart';

class UpdateUserDto {
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final bool gender;
  final String role;

  UpdateUserDto({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.role,
  });

  factory UpdateUserDto.fromEntity(UpdateUserInfo entity) {
    return UpdateUserDto(
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      birthday: entity.birthday,
      gender: entity.gender,
      role: entity.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'role': role,
    };
  }
}
