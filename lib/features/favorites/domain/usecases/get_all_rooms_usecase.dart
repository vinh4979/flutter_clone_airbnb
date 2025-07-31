import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/features/favorites/domain/repositories/favorites_repository.dart';

class GetAllRoomsUseCase {
  final FavoritesRepository repository;

  GetAllRoomsUseCase(this.repository);

  Future<List<RoomModel>> call() {
    return repository.getAllRooms();
  }
}
