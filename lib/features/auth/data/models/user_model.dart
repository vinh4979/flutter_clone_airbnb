import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.email,
    required super.name,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      token: json['accessToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'accessToken': token};
  }
}

class RegisterModel extends RegisterUser {
  const RegisterModel({required super.email, required super.password});
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
