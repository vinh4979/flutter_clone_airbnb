import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/core/api/api_client_provider.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/core/utils/jwt_decoder.dart';
import '../../domain/entities/booking.dart';

final tripsProvider = FutureProvider<List<Booking>>((ref) async {
  final api = ref.read(apiClientProvider);
  final token = await ref.read(secureStorageProvider).readToken();

  if (token == null) {
    print('❌ Không tìm thấy token. Người dùng chưa đăng nhập.');
    return [];
  }

  final userId = JwtDecoder.getUserId(token);
  final url = '/dat-phong/lay-theo-nguoi-dung/$userId';

  print('🔐 Token: $token');
  print('🆔 User ID từ token: $userId');
  print('🌐 Gọi API: $url');

  try {
    final res = await api.get(url);
    final list = res.data['content'] as List;
    print('✅ Đã nhận được ${list.length} bookings.');
    return list.map((e) => Booking.fromJson(e)).toList();
  } catch (e) {
    print('🚨 Lỗi khi gọi API $url: $e');
    rethrow;
  }
});

final upcomingTripsProvider = Provider<List<Booking>>((ref) {
  final bookings = ref.watch(tripsProvider).value ?? [];
  final now = DateTime.now();
  return bookings.where((b) => b.ngayDen.isAfter(now)).toList();
});

final pastTripsProvider = Provider<List<Booking>>((ref) {
  final bookings = ref.watch(tripsProvider).value ?? [];
  final now = DateTime.now();
  return bookings.where((b) => b.ngayDi.isBefore(now)).toList();
});
