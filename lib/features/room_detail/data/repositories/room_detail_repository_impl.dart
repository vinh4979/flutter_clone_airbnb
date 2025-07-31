import 'package:airbnb_clone_flutter/features/room_detail/data/datasources/room_detail_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/location.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/room_detail.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/repositories/room_detail_repository.dart';

class RoomDetailRepositoryImpl implements RoomDetailRepository {
  final RoomDetailRemoteDataSource remoteDataSource;

  RoomDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<RoomDetail> getRoomDetail(int roomId) async {
    final model = await remoteDataSource.fetchRoomDetail(roomId);
    return model.toEntity();
  }

  @override
  Future<RoomLocation> getLocation(int locationId) async {
    final model = await remoteDataSource.fetchRoomLocation(locationId);
    return model.toEntity();
  }

  @override
  Future<List<RoomComment>> getCommentsByRoom(int roomId) async {
    final models = await remoteDataSource.fetchRoomComments(roomId);
    return models.map((m) => m.toEntity()).toList(); // convert tại repository
  }
}
