import 'package:airbnb_clone_flutter/core/api/api_client.dart';

class BookingRemoteDataSource {
  final ApiClient api;

  BookingRemoteDataSource(this.api);

  Future<void> bookRoom({
    required int maPhong,
    required DateTime ngayDen,
    required DateTime ngayDi,
    required int soLuongKhach,
    required int maNguoiDung,
  }) async {
    await api.post(
      '/dat-phong',
      data: {
        'maPhong': maPhong,
        'ngayDen': ngayDen.toIso8601String(),
        'ngayDi': ngayDi.toIso8601String(),
        'soLuongKhach': soLuongKhach,
        'maNguoiDung': maNguoiDung,
      },
    );
  }
}
