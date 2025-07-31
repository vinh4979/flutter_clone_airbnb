import 'package:airbnb_clone_flutter/features/inbox/presentation/widgets/inbox_logged_in_view.dart';
import 'package:airbnb_clone_flutter/features/inbox/presentation/widgets/inbox_logged_out_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: SecureStorage().readToken(),
      builder: (context, snapshot) {
        final token = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (token != null && token.isNotEmpty) {
          return const InboxLoggedInView();
        } else {
          return const InboxLoggedOutView();
        }
      },
    );
  }
}
