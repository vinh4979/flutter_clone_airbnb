import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final likedRoomsProvider = StateNotifierProvider<LikedRoomsNotifier, Set<int>>(
  (ref) => LikedRoomsNotifier(),
);

class LikedRoomsNotifier extends StateNotifier<Set<int>> {
  LikedRoomsNotifier() : super({}) {
    _loadFromHive();
  }

  final _box = Hive.box('liked_rooms');

  void _loadFromHive() {
    final ids = _box.get('liked', defaultValue: <int>[]);
    state = Set<int>.from(ids);
  }

  void toggleLike(int roomId) {
    final updated = Set<int>.from(state);
    if (updated.contains(roomId)) {
      updated.remove(roomId);
    } else {
      updated.add(roomId);
    }
    state = updated;
    _box.put('liked', updated.toList());
  }

  bool isLiked(int roomId) => state.contains(roomId);
}
