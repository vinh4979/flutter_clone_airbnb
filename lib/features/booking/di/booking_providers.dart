import 'package:airbnb_clone_flutter/core/api/api_client_provider.dart';
import 'package:airbnb_clone_flutter/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:airbnb_clone_flutter/features/booking/domain/repositories/booking_repository.dart';
import 'package:airbnb_clone_flutter/features/booking/domain/usecases/book_room_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteDataSourceProvider = Provider(
  (ref) => BookingRemoteDataSource(ref.read(apiClientProvider)),
);

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepositoryImpl(ref.read(bookingRemoteDataSourceProvider)),
);

final bookRoomUseCaseProvider = Provider(
  (ref) => BookRoomUseCase(ref.read(bookingRepositoryProvider)),
);
