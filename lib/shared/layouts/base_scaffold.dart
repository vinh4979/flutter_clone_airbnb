import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;

  const BaseScaffold({
    super.key,
    this.title,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      // showAppBar
      //     ? (appBar ??
      //         AppBar(
      //           title: title != null ? Text(title!) : null,
      //           centerTitle: true,
      //           actions: const [ThemeSwitcher()],
      //         ))
      // : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
