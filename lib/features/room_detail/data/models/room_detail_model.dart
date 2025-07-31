import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/room_detail.dart';

class RoomDetailModel {
  final int id;
  final String tenPhong;
  final int khach;
  final int phongNgu;
  final int giuong;
  final int phongTam;
  final String moTa;
  final double giaTien;
  final bool mayGiat;
  final bool banLa;
  final bool tivi;
  final bool dieuHoa;
  final bool wifi;
  final bool bep;
  final bool doXe;
  final bool hoBoi;
  final bool banUi;
  final int maViTri;
  final String hinhAnh;

  RoomDetailModel({
    required this.id,
    required this.tenPhong,
    required this.khach,
    required this.phongNgu,
    required this.giuong,
    required this.phongTam,
    required this.moTa,
    required this.giaTien,
    required this.mayGiat,
    required this.banLa,
    required this.tivi,
    required this.dieuHoa,
    required this.wifi,
    required this.bep,
    required this.doXe,
    required this.hoBoi,
    required this.banUi,
    required this.maViTri,
    required this.hinhAnh,
  });

  RoomDetail toEntity() {
    return RoomDetail(
      id: id,
      tenPhong: tenPhong,
      khach: khach,
      phongNgu: phongNgu,
      giuong: giuong,
      phongTam: phongTam,
      moTa: moTa,
      giaTien: giaTien.toInt(),
      mayGiat: mayGiat,
      banLa: banLa,
      tivi: tivi,
      dieuHoa: dieuHoa,
      wifi: wifi,
      bep: bep,
      doXe: doXe,
      hoBoi: hoBoi,
      banUi: banUi,
      maViTri: maViTri,
      hinhAnh: hinhAnh,
    );
  }

  factory RoomDetailModel.fromJson(Map<String, dynamic> json) {
    return RoomDetailModel(
      id: json['id'],
      tenPhong: json['tenPhong'],
      khach: json['khach'],
      phongNgu: json['phongNgu'],
      giuong: json['giuong'],
      phongTam: json['phongTam'],
      moTa: json['moTa'],
      giaTien: (json['giaTien'] as num).toDouble(),
      mayGiat: json['mayGiat'],
      banLa: json['banLa'],
      tivi: json['tivi'],
      dieuHoa: json['dieuHoa'],
      wifi: json['wifi'],
      bep: json['bep'],
      doXe: json['doXe'],
      hoBoi: json['hoBoi'],
      banUi: json['banUi'],
      maViTri: json['maViTri'],
      hinhAnh: json['hinhAnh'],
    );
  }
}
