import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/room_detail.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/location.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/repositories/room_detail_repository.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/repositories/room_detail_repository_impl.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/datasources/room_detail_remote_datasource.dart';
import 'package:airbnb_clone_flutter/core/api/api_client.dart';

// 🔹 Repository Provider
final roomDetailRepositoryProvider = Provider<RoomDetailRepository>((ref) {
  final apiClient = ApiClient();
  final remoteDataSource = RoomDetailRemoteDataSource(apiClient);
  return RoomDetailRepositoryImpl(remoteDataSource);
});

// 🔹 Room Detail Provider
final roomDetailProvider = FutureProvider.family<RoomDetail, int>((
  ref,
  roomId,
) {
  final repo = ref.read(roomDetailRepositoryProvider);
  return repo.getRoomDetail(roomId);
});

// 🔹 Location Provider
final roomLocationProvider = FutureProvider.family<RoomLocation, int>((
  ref,
  locationId,
) {
  final repo = ref.read(roomDetailRepositoryProvider);
  return repo.getLocation(locationId);
});

// 🔹 Comment List Provider
final roomCommentsProvider = FutureProvider.family<List<RoomComment>, int>((
  ref,
  roomId,
) {
  final repo = ref.read(roomDetailRepositoryProvider);
  return repo.getCommentsByRoom(roomId);
});
