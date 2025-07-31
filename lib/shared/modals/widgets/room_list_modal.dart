import 'package:airbnb_clone_flutter/shared/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/location_model.dart';

class RoomListModal extends StatelessWidget {
  final LocationModel location;
  final List<RoomModel> rooms;

  const RoomListModal({super.key, required this.location, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỗ ở tại ${location.tinhThanh}"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.separated(
        itemCount: rooms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(room: room, width: double.infinity);
        },
      ),
    );
  }
}
