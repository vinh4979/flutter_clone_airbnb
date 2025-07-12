// lib/shared/utils/validators.dart
class Validators {
  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu tối thiểu 6 ký tự';
    }
    if (!RegExp(r'(?=.*[A-Z])(?=.*[0-9])').hasMatch(value)) {
      return 'Phải có chữ hoa và số';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    if (value != original) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }
}
