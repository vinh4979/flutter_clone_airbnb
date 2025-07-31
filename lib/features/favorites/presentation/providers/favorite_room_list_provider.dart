// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:airbnb_clone_flutter/features/favorites/domain/entities/room.dart';
// import 'package:airbnb_clone_flutter/features/favorites/domain/usecases/get_all_rooms_usecase.dart';
// import 'package:airbnb_clone_flutter/features/favorites/data/datasources/favorites_remote_datasource.dart';
// import 'package:airbnb_clone_flutter/features/favorites/data/repositories/favorites_repository_impl.dart';

// // ✅ Usecase provider
// final getAllRoomsUsecaseProvider = Provider<GetAllRoomsUsecase>((ref) {
//   final remote = FavoritesRemoteDataSource();
//   final repository = FavoritesRepositoryImpl(remote);
//   return GetAllRoomsUsecase(repository);
// });

// // ✅ Provider: Lấy danh sách phòng đã like (lọc theo Hive)
// final favoriteRoomListProvider = FutureProvider<List<Room>>((ref) async {
//   final usecase = ref.watch(getAllRoomsUsecaseProvider);
//   final allRooms = await usecase();

//   final likedBox = Hive.box('liked_rooms');
//   final likedIds =
//       likedBox.get('liked', defaultValue: <int>[]) as List<dynamic>;
//   final idSet = Set<int>.from(likedIds);

//   return allRooms.where((room) => idSet.contains(room.id)).toList();
// });
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/favorites/di/favorites_providers.dart';

final favoriteRoomListProvider = FutureProvider<List<RoomModel>>((ref) {
  final usecase = ref.read(getAllRoomsUseCaseProvider);
  return usecase();
});
