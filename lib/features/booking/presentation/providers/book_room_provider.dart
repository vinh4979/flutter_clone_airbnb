import 'package:airbnb_clone_flutter/features/booking/di/booking_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookRoomProvider =
    StateNotifierProvider<BookRoomController, AsyncValue<void>>(
      (ref) => BookRoomController(ref),
    );

class BookRoomController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  BookRoomController(this.ref) : super(const AsyncValue.data(null));

  Future<void> bookRoom({
    required int maPhong,
    required DateTime ngayDen,
    required DateTime ngayDi,
    required int soLuongKhach,
    required int maNguoiDung,
  }) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(bookRoomUseCaseProvider);
      await usecase(
        maPhong: maPhong,
        ngayDen: ngayDen,
        ngayDi: ngayDi,
        soLuongKhach: soLuongKhach,
        maNguoiDung: maNguoiDung,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
