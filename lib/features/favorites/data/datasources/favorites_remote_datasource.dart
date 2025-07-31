import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';

class FavoritesRemoteDataSource {
  final _apiClient = ApiClient();

  Future<List<RoomModel>> fetchAllRooms() async {
    final res = await _apiClient.get('/phong-thue');
    final List data = res.data['content'];
    return data.map((e) => RoomModel.fromJson(e)).toList();
  }
}
