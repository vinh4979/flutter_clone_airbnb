import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/core/api/api_client.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/datasources/room_detail_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/room_detail/data/repositories/room_detail_repository_impl.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/repositories/room_detail_repository.dart';

/// ✅ Provider cho ApiClient riêng (nếu không dùng chung Dio)
final roomDetailApiClientProvider = Provider<ApiClient>((ref) => ApiClient());

/// ✅ Provider cho RemoteDataSource
final roomDetailRemoteDataSourceProvider = Provider<RoomDetailRemoteDataSource>(
  (ref) {
    final api = ref.read(roomDetailApiClientProvider);
    return RoomDetailRemoteDataSource(api);
  },
);

/// ✅ Provider cho Repository
final roomDetailRepositoryProvider = Provider<RoomDetailRepository>((ref) {
  final remoteDataSource = ref.read(roomDetailRemoteDataSourceProvider);
  return RoomDetailRepositoryImpl(remoteDataSource);
});
