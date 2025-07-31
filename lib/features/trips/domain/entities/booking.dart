class Booking {
  final int id;
  final int maPhong;
  final DateTime ngayDen;
  final DateTime ngayDi;
  final int soLuongKhach;
  final int maNguoiDung;

  Booking({
    required this.id,
    required this.maPhong,
    required this.ngayDen,
    required this.ngayDi,
    required this.soLuongKhach,
    required this.maNguoiDung,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      maPhong: json['maPhong'],
      ngayDen: DateTime.parse(json['ngayDen']),
      ngayDi: DateTime.parse(json['ngayDi']),
      soLuongKhach: json['soLuongKhach'],
      maNguoiDung: json['maNguoiDung'],
    );
  }
}
