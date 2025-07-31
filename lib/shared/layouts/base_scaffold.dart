import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool showAppBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const BaseScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.showAppBar = false,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? appBar : null,
      backgroundColor: backgroundColor ?? Colors.white,
      body: SafeArea(
        child: body, // 👈 luôn có SafeArea ở đây
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
