import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/providers/trips_provider.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/widgets/trip_logged_out_view.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/widgets/trip_logged_in_empty_view.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/widgets/trip_tab_view.dart'; // bạn sẽ tạo ở bước 4

class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {
  String? _token;

  @override
  Widget build(BuildContext context) {
    // Lắng nghe thay đổi token để rebuild
    ref.listen<String?>(tokenProvider, (previous, next) {
      if (previous != next) {
        setState(() => _token = next);
      }
    });

    // Lấy token lần đầu nếu chưa có
    _token ??= ref.read(tokenProvider);

    // Trường hợp chưa đăng nhập
    if (_token == null) {
      return const TripLoggedOutView();
    }

    // Đã đăng nhập → load danh sách chuyến đi
    final tripsAsync = ref.watch(tripsProvider);

    return tripsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Lỗi: $e')),
      data: (bookings) {
        // Kiểm tra nếu không có chuyến đi nào
        final hasTrips = bookings.any(
          (trip) =>
              trip.ngayDen.isAfter(DateTime.now()) ||
              trip.ngayDi.isBefore(DateTime.now()),
        );

        if (!hasTrips) return const TripLoggedInEmptyView();

        // Có ít nhất 1 chuyến đi
        return const TripTabView();
      },
    );
  }
}
