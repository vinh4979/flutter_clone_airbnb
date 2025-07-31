abstract class BookingRepository {
  Future<void> bookRoom({
    required int maPhong,
    required DateTime ngayDen,
    required DateTime ngayDi,
    required int soLuongKhach,
    required int maNguoiDung,
  });
}
