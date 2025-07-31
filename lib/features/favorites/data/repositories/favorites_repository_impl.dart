import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RoomModel>> getAllRooms() {
    return remoteDataSource.fetchAllRooms();
  }
}
