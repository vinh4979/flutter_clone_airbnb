import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/domain/entities/user.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/data/user_remote_datasource.dart';
import 'package:airbnb_clone_flutter/core/utils/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileProvider = FutureProvider<User>((ref) async {
  final token = ref.watch(tokenProvider);

  if (token == null) throw Exception("Chưa đăng nhập");

  final userId = JwtDecoder.getUserId(token);
  final remote = ref.read(userRemoteDataSourceProvider);
  return await remote.getUserById(userId);
});
