import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRoomCard extends StatelessWidget {
  const ShimmerRoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 12, width: 160, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 12, width: 100, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 12, width: 50, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
