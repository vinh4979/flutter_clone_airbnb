import 'dart:math';

final _random = Random();

String getRandomFallbackRoomImage() {
  final index = _random.nextInt(10) + 1; // 1 đến 10
  return 'assets/images/rooms/room_$index.avif';
}

bool isValidHttpUrl(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  final uri = Uri.tryParse(url.trim());
  return uri != null &&
      (uri.isScheme('http') || uri.isScheme('https')) &&
      uri.host.isNotEmpty;
}
