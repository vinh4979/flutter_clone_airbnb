import 'package:flutter/material.dart';

class RoomDetailImageHeader extends StatelessWidget {
  final String imageUrl;
  final double offset;

  const RoomDetailImageHeader({
    super.key,
    required this.imageUrl,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -offset * 0.4,
      left: 0,
      right: 0,
      child: Image.network(
        imageUrl,
        height: 300 + offset * 0.2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: 300,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 300,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }
}
