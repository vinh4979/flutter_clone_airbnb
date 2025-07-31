import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';

abstract class FavoritesRepository {
  Future<List<RoomModel>> getAllRooms();
}
