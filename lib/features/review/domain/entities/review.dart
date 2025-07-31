class Review {
  final int maPhong;
  final int maNguoiBinhLuan;
  final String ngayBinhLuan;
  final String noiDung;
  final int saoBinhLuan;

  Review({
    required this.maPhong,
    required this.maNguoiBinhLuan,
    required this.ngayBinhLuan,
    required this.noiDung,
    required this.saoBinhLuan,
  });

  Map<String, dynamic> toJson() {
    return {
      'maPhong': maPhong,
      'maNguoiBinhLuan': maNguoiBinhLuan,
      'ngayBinhLuan': ngayBinhLuan,
      'noiDung': noiDung,
      'saoBinhLuan': saoBinhLuan,
    };
  }
}
