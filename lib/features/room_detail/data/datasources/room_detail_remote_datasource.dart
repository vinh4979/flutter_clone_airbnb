import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/models/comment_model.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/models/location_model.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/models/room_detail_model.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';

class RoomDetailRemoteDataSource {
  final ApiClient _apiClient;

  RoomDetailRemoteDataSource(this._apiClient);

  /// 🔹 Lấy chi tiết phòng theo ID
  Future<RoomDetailModel> fetchRoomDetail(int roomId) async {
    final response = await _apiClient.get('/phong-thue/$roomId');
    final json = response.data['content'];
    return RoomDetailModel.fromJson(json);
  }

  /// 🔹 Lấy vị trí phòng từ `maViTri`
  Future<RoomLocationModel> fetchRoomLocation(int locationId) async {
    final response = await _apiClient.get('/vi-tri/$locationId');
    final json = response.data['content'];
    return RoomLocationModel.fromJson(json);
  }

  /// 🔹 Lấy bình luận theo ID phòng
  Future<List<RoomCommentModel>> fetchRoomComments(int roomId) async {
    final response = await _apiClient.get(
      '/binh-luan/lay-binh-luan-theo-phong/$roomId',
    );
    final List<dynamic> list = response.data['content'];
    return list.map((e) => RoomCommentModel.fromJson(e)).toList();
  }

  Future<List<RoomComment>> fetchCommentsByRoom(int roomId) async {
    final response = await _apiClient.get(
      '/binh-luan/lay-binh-luan-theo-phong/$roomId',
    );
    final data = response.data['content'] as List;

    return data
        .map((json) => RoomCommentModel.fromJson(json).toEntity())
        .toList();
  }
}
