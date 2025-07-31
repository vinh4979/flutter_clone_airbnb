import 'package:airbnb_clone_flutter/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/features/search_rooms/presentation/providers/search_rooms_provider.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';
import 'package:airbnb_clone_flutter/shared/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchRoomsScreen extends ConsumerWidget {
  const SearchRoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final condition = ref.watch(searchRoomsConditionProvider);

    if (condition == null) {
      return const Scaffold(
        body: Center(child: Text("Không có điều kiện tìm kiếm")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Kết quả tìm kiếm")),
      body: FutureBuilder<List<RoomModel>>(
        future: ExploreRemoteDataSource().fetchRoomsByLocation(
          condition.maViTri,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final rooms = snapshot.data ?? [];

          if (rooms.isEmpty) {
            return const Center(child: Text("Không tìm thấy phòng nào"));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: rooms.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final room = rooms[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    showAppModal(
                      context,
                      AppModalType.roomDetail,
                      data: {'roomId': room.id},
                    );
                  },
                  child: RoomCard(room: room),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
