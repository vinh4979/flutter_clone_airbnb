import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/location.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/room_detail.dart';

abstract class RoomDetailRepository {
  Future<RoomDetail> getRoomDetail(int roomId);
  Future<RoomLocation> getLocation(int locationId);
  Future<List<RoomComment>> getCommentsByRoom(int roomId);
}
