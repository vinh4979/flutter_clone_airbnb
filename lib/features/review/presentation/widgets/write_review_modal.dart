import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../review/data/datasources/review_remote_datasource.dart';
import '../../../review/domain/entities/review.dart';
import '../../../../core/utils/jwt_decoder.dart';

class WriteReviewModal extends ConsumerStatefulWidget {
  final int roomId;

  const WriteReviewModal({super.key, required this.roomId});

  @override
  ConsumerState<WriteReviewModal> createState() => _WriteReviewModalState();
}

class _WriteReviewModalState extends ConsumerState<WriteReviewModal> {
  int selectedStars = 5;
  final TextEditingController _controller = TextEditingController();
  bool isSubmitting = false;

  Future<void> submitReview() async {
    final token = await ref.read(secureStorageProvider).readToken();
    if (token == null) return;

    final userId = JwtDecoder.getUserId(token);
    final today = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final review = Review(
      maPhong: widget.roomId,
      maNguoiBinhLuan: userId,
      ngayBinhLuan: today,
      noiDung: _controller.text.trim(),
      saoBinhLuan: selectedStars,
    );

    setState(() => isSubmitting = true);

    try {
      await ref.read(reviewRemoteDatasourceProvider).postReview(review, token);

      if (mounted) Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã gửi đánh giá thành công!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi gửi đánh giá: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Đánh giá chuyến đi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // ⭐ Stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final star = index + 1;
                    return IconButton(
                      onPressed: () => setState(() => selectedStars = star),
                      icon: Icon(
                        Icons.star,
                        color:
                            star <= selectedStars
                                ? Colors.orange
                                : Colors.grey.shade400,
                      ),
                    );
                  }),
                ),

                // ✏️ Input
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Chia sẻ trải nghiệm của bạn...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // 📨 Gửi
                ElevatedButton(
                  onPressed: isSubmitting ? null : submitReview,
                  child:
                      isSubmitting
                          ? const CircularProgressIndicator()
                          : const Text('Gửi đánh giá'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
