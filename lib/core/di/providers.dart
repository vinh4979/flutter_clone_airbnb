import 'package:airbnb_clone_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:airbnb_clone_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';

final dioProvider = Provider<Dio>((ref) => ApiClient().dio);

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.read(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider)),
);
