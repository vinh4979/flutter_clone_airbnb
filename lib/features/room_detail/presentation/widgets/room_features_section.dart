import 'package:flutter/material.dart';

class RoomFeaturesSection extends StatelessWidget {
  final dynamic room;

  const RoomFeaturesSection({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        children: [
          if (room.wifi) const Chip(label: Text("Wi-Fi")),
          if (room.dieuHoa) const Chip(label: Text("Điều hoà")),
          if (room.hoBoi) const Chip(label: Text("Hồ bơi")),
          if (room.doXe) const Chip(label: Text("Bãi đỗ xe")),
          if (room.banLa) const Chip(label: Text("Bàn ủi")),
        ],
      ),
    );
  }
}
