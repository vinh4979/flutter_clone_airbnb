import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/favorites/di/favorites_providers.dart';

final favoriteRoomListProvider = FutureProvider<List<RoomModel>>((ref) {
  final usecase = ref.read(getAllRoomsUseCaseProvider);
  return usecase();
});
