import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider dùng để trigger reload profile
/// Khi được set `true`, các màn hình (như ProfileScreen) sẽ listen và invalidate các provider liên quan.
final refreshProfileProvider = StateProvider<bool>((ref) => false);
