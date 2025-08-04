import 'dart:math';

class RoomStyleUtil {
  static final List<String> _roomStyles = [
    'Phòng tối giản kiểu Nhật',
    'Phòng mang phong cách Scandinavian',
    'Phòng nghỉ dưỡng kiểu resort',
    'Phòng vintage trong nhà cổ',
    'Phòng hiện đại với nội thất thông minh',
  ];

  // Trả về một phong cách ngẫu nhiên
  static String getRandomStyle() {
    final random = Random();
    return _roomStyles[random.nextInt(_roomStyles.length)];
  }
}
