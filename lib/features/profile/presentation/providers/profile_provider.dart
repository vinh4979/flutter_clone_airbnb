import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Giải mã token để lấy user ID
final decodedProfileUserProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  final token = await SecureStorage().readToken();
  if (token == null || token.isEmpty) throw Exception('Token không tồn tại');
  return JwtDecoder.decode(token);
});

/// Gọi API lấy thông tin user từ ID
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final decoded = await ref.watch(decodedProfileUserProvider.future);
  final userId = int.parse(decoded['id'].toString());

  final dio = ApiClient().dio;
  final remoteDataSource = ProfileRemoteDataSource(dio);
  final userProfileModel = await remoteDataSource.getUserProfile(userId);
  return userProfileModel.toEntity();
});

/// ⚡ Provider trigger reload
final shouldRefreshProfileProvider = StateProvider<bool>((ref) => false);
