import 'package:flutter/material.dart';

class ScrollListRoom extends StatelessWidget {
  final String title;
  final List<Widget> listRoomWidgets;

  const ScrollListRoom({
    super.key,
    required this.title,
    required this.listRoomWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: listRoomWidgets.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) => listRoomWidgets[index],
          ),
        ),
      ],
    );
  }
}
