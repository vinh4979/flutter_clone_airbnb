import 'package:flutter/material.dart';

class RoomTitleSection extends StatelessWidget {
  final String roomName;
  final String locationName;
  final double averageRating;
  final int totalReviews;
  final String roomTypeDescription;

  const RoomTitleSection({
    super.key,
    required this.roomName,
    required this.locationName,
    required this.averageRating,
    required this.totalReviews,
    required this.roomTypeDescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Tiêu đề
          Text(
            roomName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 2. Mô tả location
          Text(
            'Phòng tại $locationName',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // 3. Mô tả giường & tắm
          Text(
            roomTypeDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
