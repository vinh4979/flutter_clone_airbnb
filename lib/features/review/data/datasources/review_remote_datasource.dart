import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api/api_client_provider.dart';
import '../../domain/entities/review.dart';

final reviewRemoteDatasourceProvider = Provider<ReviewRemoteDatasource>((ref) {
  final dio = ref.read(apiClientProvider).dio; // 👈 lấy Dio trực tiếp
  return ReviewRemoteDatasource(dio);
});

class ReviewRemoteDatasource {
  final Dio dio;

  ReviewRemoteDatasource(this.dio);

  Future<void> postReview(Review review, String userToken) async {
    final res = await dio.post(
      '/binh-luan',
      data: review.toJson(),
      options: Options(
        headers: {
          'token': userToken,
          'Content-Type': 'application/json-patch+json',
        },
      ),
    );

    print('✅ Gửi đánh giá thành công: ${res.data}');
  }
}
