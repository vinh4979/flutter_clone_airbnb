import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:airbnb_clone_flutter/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:airbnb_clone_flutter/features/favorites/domain/usecases/get_all_rooms_usecase.dart';

// ✅ Remote datasource
final favoritesRemoteDataSourceProvider = Provider<FavoritesRemoteDataSource>((
  ref,
) {
  return FavoritesRemoteDataSource();
});

// ✅ Repository
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final dataSource = ref.watch(favoritesRemoteDataSourceProvider);
  return FavoritesRepositoryImpl(dataSource);
});

// ✅ Usecase
final getAllRoomsUseCaseProvider = Provider<GetAllRoomsUseCase>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return GetAllRoomsUseCase(repository);
});
