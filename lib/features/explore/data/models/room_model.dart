class RoomModel {
  final int id;
  final String tenPhong;
  final int khach;
  final int phongNgu;
  final int giuong;
  final int phongTam;
  final String moTa;
  final double giaTien;
  final String hinhAnh;

  RoomModel({
    required this.id,
    required this.tenPhong,
    required this.khach,
    required this.phongNgu,
    required this.giuong,
    required this.phongTam,
    required this.moTa,
    required this.giaTien,
    required this.hinhAnh,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      tenPhong: json['tenPhong'],
      khach: json['khach'],
      phongNgu: json['phongNgu'],
      giuong: json['giuong'],
      phongTam: json['phongTam'],
      moTa: json['moTa'],
      giaTien: (json['giaTien'] as num).toDouble(),
      hinhAnh: json['hinhAnh'],
    );
  }
}
