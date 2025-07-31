import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RoomAmenitiesSection extends StatelessWidget {
  final dynamic room;

  const RoomAmenitiesSection({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final amenities = _buildAmenities(room);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tiện nghi tại nơi này',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Grid dạng 2 cột
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: amenities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 40,
              crossAxisSpacing: 0,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, index) {
              return _AmenityRow(item: amenities[index]);
            },
          ),
        ],
      ),
    );
  }

  List<_Amenity> _buildAmenities(dynamic room) {
    return [
      _Amenity('Bếp', LucideIcons.utensilsCrossed, room.bep),
      _Amenity('Hồ bơi', LucideIcons.showerHead, room.hoBoi),
      _Amenity('Máy giặt', LucideIcons.laugh, room.mayGiat),
      _Amenity('Điều hoà', LucideIcons.snowflake, room.dieuHoa),
      _Amenity('TV', LucideIcons.tv, room.tivi),
      _Amenity('Wi-Fi', LucideIcons.wifi, room.wifi),
      _Amenity('Đỗ xe', LucideIcons.car, room.doXe),
      _Amenity('Bàn ủi', LucideIcons.cloudLightning, room.banUi),
      _Amenity('Bàn là', LucideIcons.shirt, room.banLa),
    ];
  }
}

class _Amenity {
  final String title;
  final IconData icon;
  final bool available;

  _Amenity(this.title, this.icon, this.available);
}

class _AmenityRow extends StatelessWidget {
  final _Amenity item;

  const _AmenityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.available ? Colors.black : Colors.grey;
    final style = TextStyle(
      fontSize: 14,
      color: color,
      decoration: item.available ? null : TextDecoration.lineThrough,
    );

    return Row(
      children: [
        Icon(item.icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(item.title, style: style)),
      ],
    );
  }
}
