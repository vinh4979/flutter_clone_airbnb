import 'dart:math';

class HostInfo {
  final String name;
  final String avatarUrl;
  final String tagline;

  HostInfo({
    required this.name,
    required this.avatarUrl,
    required this.tagline,
  });
}

class HostInfoUtil {
  static final List<HostInfo> _mockHosts = [
    HostInfo(
      name: 'Anh',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      tagline: 'Siêu thân thiện · Yêu cây cối 🌿',
    ),
    HostInfo(
      name: 'Linh',
      avatarUrl: 'https://i.pravatar.cc/150?img=21',
      tagline: 'Luôn để lại socola 🍫 cho khách!',
    ),
    HostInfo(
      name: 'Tuấn',
      avatarUrl: 'https://i.pravatar.cc/150?img=36',
      tagline: 'Chủ nhà yêu thú cưng 🐶🐱',
    ),
    HostInfo(
      name: 'Mai',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
      tagline: 'Đam mê decor & chill 🌈',
    ),
    HostInfo(
      name: 'Bảo',
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
      tagline: 'Check-in nhanh · Phòng thơm mùi quế 🍂',
    ),
    HostInfo(
      name: 'Ngọc',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      tagline: 'Mỗi khách đến đều là người bạn mới ☕',
    ),
  ];

  static HostInfo getRandomHost() {
    final random = Random();
    return _mockHosts[random.nextInt(_mockHosts.length)];
  }
}
