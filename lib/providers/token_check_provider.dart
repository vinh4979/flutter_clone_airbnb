import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenCheckProvider = FutureProvider<bool>((ref) async {
  final token = await SecureStorage().readToken();
  return token != null && token.isNotEmpty;
});
