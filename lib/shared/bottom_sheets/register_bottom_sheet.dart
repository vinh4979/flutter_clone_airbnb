import 'package:airbnb_clone_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showRegisterModal(BuildContext context) {
  showCupertinoModalBottomSheet(
    context: context,
    expand: true,
    builder: (context) => const RegisterScreen(),
  );
}
