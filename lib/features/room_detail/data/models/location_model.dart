import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/location.dart';

class RoomLocationModel {
  final int id;
  final String tenViTri;
  final String tinhThanh;
  final String quocGia;
  final String hinhAnh;

  RoomLocationModel({
    required this.id,
    required this.tenViTri,
    required this.tinhThanh,
    required this.quocGia,
    required this.hinhAnh,
  });

  RoomLocation toEntity() {
    return RoomLocation(
      id: id,
      tenViTri: tenViTri,
      tinhThanh: tinhThanh,
      quocGia: quocGia,
      hinhAnh: hinhAnh,
    );
  }

  factory RoomLocationModel.fromJson(Map<String, dynamic> json) {
    return RoomLocationModel(
      id: json['id'],
      tenViTri: json['tenViTri'],
      tinhThanh: json['tinhThanh'],
      quocGia: json['quocGia'],
      hinhAnh: json['hinhAnh'],
    );
  }
}
