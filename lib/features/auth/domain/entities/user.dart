class User {
  final String email;
  final String name;
  final String token;

  const User({required this.email, required this.name, required this.token});
}

class RegisterUser {
  final String email;
  final String password;

  const RegisterUser({required this.email, required this.password});
}
