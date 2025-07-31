import 'package:airbnb_clone_flutter/features/auth/presentation/providers/auth_token_provider.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/presentation/widgets/logged_in_profile_view.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/presentation/widgets/not_logged_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReactiveProfileScreen extends ConsumerStatefulWidget {
  const ReactiveProfileScreen({super.key});

  @override
  ConsumerState<ReactiveProfileScreen> createState() =>
      _ReactiveProfileScreenState();
}

class _ReactiveProfileScreenState extends ConsumerState<ReactiveProfileScreen> {
  String? _token;

  @override
  Widget build(BuildContext context) {
    // ✅ Theo dõi token: khi login/logout → rebuild UI
    ref.listen<String?>(tokenProvider, (previous, next) {
      if (previous != next) {
        setState(() {
          _token = next;
        });
      }
    });

    // ✅ Gán token lúc đầu
    _token ??= ref.read(tokenProvider);

    // ✅ Nếu chưa đăng nhập → hiện giao diện Airbnb
    if (_token == null) {
      return const LoggedOutProfileView();
    }

    // ✅ Nếu đã đăng nhập → hiển thị thông tin người dùng
    return LoggedInProfileView(token: _token!);
  }
}
