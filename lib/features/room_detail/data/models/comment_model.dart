import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';

class RoomCommentModel {
  final int id;
  final String ngayBinhLuan;
  final String noiDung;
  final int saoBinhLuan;
  final String tenNguoiBinhLuan;
  final String avatar;

  RoomCommentModel({
    required this.id,
    required this.ngayBinhLuan,
    required this.noiDung,
    required this.saoBinhLuan,
    required this.tenNguoiBinhLuan,
    required this.avatar,
  });

  factory RoomCommentModel.fromJson(Map<String, dynamic> json) {
    return RoomCommentModel(
      id: json['id'],
      ngayBinhLuan: json['ngayBinhLuan'],
      noiDung: json['noiDung'],
      saoBinhLuan: json['saoBinhLuan'],
      tenNguoiBinhLuan: json['tenNguoiBinhLuan'],
      avatar: json['avatar'] ?? '',
    );
  }

  RoomComment toEntity() {
    return RoomComment(
      id: id,
      ngayBinhLuan: ngayBinhLuan,
      noiDung: noiDung,
      saoBinhLuan: saoBinhLuan,
      tenNguoiBinhLuan: tenNguoiBinhLuan,
      avatar: avatar,
    );
  }
}
