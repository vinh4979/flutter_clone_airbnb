class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final String? avatar;
  final bool gender;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.avatar,
    required this.gender,
    required this.role,
  });
  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? birthday,
    bool? gender,
    String? role,
    String? avatar,
  }) {
    return User(
      id: id, // không đổi
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    birthday: json['birthday'],
    avatar: json['avatar'],
    gender: json['gender'],
    role: json['role'],
  );
}
