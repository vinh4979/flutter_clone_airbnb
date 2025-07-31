import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String email,
    required String token,
  }) : super(id: id, name: name, email: email, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    return UserModel(
      id: userJson['id'] ?? 0,
      name: userJson['name'] ?? '',
      email: userJson['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
