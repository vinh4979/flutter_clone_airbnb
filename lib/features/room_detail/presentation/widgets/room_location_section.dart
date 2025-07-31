import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomLocationSection extends StatelessWidget {
  final AsyncValue locationAsync;

  const RoomLocationSection({super.key, required this.locationAsync});

  @override
  Widget build(BuildContext context) {
    return locationAsync.when(
      data:
          (location) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  '${location.tenViTri}, ${location.tinhThanh}, ${location.quocGia}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Lỗi vị trí: $e"),
    );
  }
}
