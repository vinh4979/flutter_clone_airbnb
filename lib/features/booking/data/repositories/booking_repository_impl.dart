import 'package:airbnb_clone_flutter/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> bookRoom({
    required int maPhong,
    required DateTime ngayDen,
    required DateTime ngayDi,
    required int soLuongKhach,
    required int maNguoiDung,
  }) {
    return remoteDataSource.bookRoom(
      maPhong: maPhong,
      ngayDen: ngayDen,
      ngayDi: ngayDi,
      soLuongKhach: soLuongKhach,
      maNguoiDung: maNguoiDung,
    );
  }
}
