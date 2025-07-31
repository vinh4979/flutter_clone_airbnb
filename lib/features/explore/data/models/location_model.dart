class LocationModel {
  final int id;
  final String tenViTri;
  final String tinhThanh;
  final String quocGia;
  final String hinhAnh;

  LocationModel({
    required this.id,
    required this.tenViTri,
    required this.tinhThanh,
    required this.quocGia,
    required this.hinhAnh,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      tenViTri: json['tenViTri'],
      tinhThanh: json['tinhThanh'],
      quocGia: json['quocGia'],
      hinhAnh: json['hinhAnh'],
    );
  }
}
