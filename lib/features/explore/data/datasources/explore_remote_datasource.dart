import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/location_model.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';

class ExploreRemoteDataSource {
  final _dio = ApiClient().dio;

  Future<List<LocationModel>> fetchLocations() async {
    final res = await _dio.get('/vi-tri');
    return (res.data['content'] as List)
        .map((e) => LocationModel.fromJson(e))
        .toList();
  }

  Future<List<RoomModel>> fetchRoomsByLocation(int locationId) async {
    final res = await _dio.get(
      '/phong-thue/lay-phong-theo-vi-tri?maViTri=$locationId',
    );
    return (res.data['content'] as List)
        .map((e) => RoomModel.fromJson(e))
        .toList();
  }
}
