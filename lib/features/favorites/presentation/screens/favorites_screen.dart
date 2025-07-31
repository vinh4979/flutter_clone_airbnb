import 'package:airbnb_clone_flutter/features/favorites/presentation/widgets/favorites_logged_out_view.dart';
import 'package:airbnb_clone_flutter/providers/token_check_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/providers/liked_rooms_provider.dart';
import 'package:airbnb_clone_flutter/features/favorites/presentation/providers/favorite_room_list_provider.dart';
import 'package:airbnb_clone_flutter/shared/widgets/room_card.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedInAsync = ref.watch(tokenCheckProvider);

    return isLoggedInAsync.when(
      data: (isLoggedIn) {
        if (!isLoggedIn) return const FavoritesLoggedOutView();

        final likedIds = ref.watch(likedRoomsProvider);
        final roomListAsync = ref.watch(favoriteRoomListProvider);

        return roomListAsync.when(
          data: (rooms) {
            final likedRooms =
                rooms.where((room) => likedIds.contains(room.id)).toList();

            if (likedRooms.isEmpty) return const _EmptyFavoriteView();

            return Scaffold(
              appBar: AppBar(title: const Text('Yêu thích'), centerTitle: true),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: likedRooms.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 270,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, index) => RoomCard(room: likedRooms[index]),
                ),
              ),
            );
          },
          loading:
              () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
          error:
              (e, _) =>
                  Scaffold(body: Center(child: Text('Lỗi khi tải phòng: $e'))),
        );
      },
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Lỗi xác thực: $e'))),
    );
  }
}

class _EmptyFavoriteView extends StatelessWidget {
  const _EmptyFavoriteView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yêu thích',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Chưa có phòng nào được bạn đánh dấu là yêu thích.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
