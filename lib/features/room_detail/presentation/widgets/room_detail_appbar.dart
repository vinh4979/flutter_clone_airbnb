import 'package:flutter/material.dart';

class RoomDetailAppBar extends StatelessWidget {
  final double offset;
  final String title;
  final VoidCallback onBack;

  const RoomDetailAppBar({
    super.key,
    required this.offset,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final double safeTop = MediaQuery.of(context).padding.top;

    final double progress = (offset / 100).clamp(0.0, 1.0);
    final Color backgroundColor = Colors.white.withValues(
      alpha: progress * 255,
    );
    final Color iconColor =
        Color.lerp(Colors.white, Colors.grey.shade800, progress)!;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: safeTop + 60,
        padding: EdgeInsets.only(top: safeTop, left: 8, right: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow:
              progress > 0.05
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: onBack,
            ),
            IconButton(
              icon: Icon(Icons.favorite_border, color: iconColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
