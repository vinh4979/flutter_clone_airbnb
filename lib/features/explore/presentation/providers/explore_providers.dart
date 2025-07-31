import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/location_model.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';

// ✅ Danh sách vị trí
final locationListProvider = FutureProvider<List<LocationModel>>((ref) async {
  return ExploreRemoteDataSource().fetchLocations();
});

// ✅ ID vị trí được chọn
final selectedLocationProvider = StateProvider<int?>((ref) => null);

// ✅ Danh sách phòng theo vị trí
final roomListProvider = FutureProvider.autoDispose
    .family<List<RoomModel>, int>((ref, locationId) async {
      return ExploreRemoteDataSource().fetchRoomsByLocation(locationId);
    });
