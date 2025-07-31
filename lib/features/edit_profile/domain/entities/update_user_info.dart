class UpdateUserInfo {
  final String name;
  final String email;
  final String phone;
  final String birthday; // dạng dd-MM-yyyy
  final bool gender;
  final String role;

  const UpdateUserInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.role,
  });
}
