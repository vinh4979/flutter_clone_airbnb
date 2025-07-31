import 'package:airbnb_clone_flutter/features/booking/domain/repositories/booking_repository.dart';

class BookRoomUseCase {
  final BookingRepository repository;

  BookRoomUseCase(this.repository);

  Future<void> call({
    required int maPhong,
    required DateTime ngayDen,
    required DateTime ngayDi,
    required int soLuongKhach,
    required int maNguoiDung,
  }) {
    return repository.bookRoom(
      maPhong: maPhong,
      ngayDen: ngayDen,
      ngayDi: ngayDi,
      soLuongKhach: soLuongKhach,
      maNguoiDung: maNguoiDung,
    );
  }
}
