import 'dart:convert';

class JwtDecoder {
  static int getUserId(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception("Token không hợp lệ");
    }

    final payloadMap = json.decode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
    );

    final id = payloadMap['id'];
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? -1;

    throw Exception("Không lấy được ID người dùng");
  }
}
