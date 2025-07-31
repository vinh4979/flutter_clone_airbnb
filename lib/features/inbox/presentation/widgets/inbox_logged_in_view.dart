import 'package:flutter/material.dart';

class InboxLoggedInView extends StatelessWidget {
  const InboxLoggedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hộp thư')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hộp thư',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: const [
                FilterChip(
                  label: Text('Tất cả'),
                  selected: true,
                  onSelected: null,
                  showCheckmark: false,
                ),
                FilterChip(
                  label: Text('Du lịch'),
                  selected: false,
                  onSelected: null,
                  showCheckmark: false,
                ),
                FilterChip(
                  label: Text('Hỗ trợ'),
                  selected: false,
                  onSelected: null,
                  showCheckmark: false,
                ),
              ],
            ),
            const SizedBox(height: 64),
            const Center(
              child: Column(
                children: [
                  Icon(Icons.markunread_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Bạn không có tin nhắn nào',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Khi bạn nhận được tin nhắn mới, tin nhắn đó sẽ xuất hiện ở đây.',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
