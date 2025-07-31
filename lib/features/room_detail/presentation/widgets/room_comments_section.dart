import 'package:airbnb_clone_flutter/core/utils/comment_date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomCommentsSection extends StatelessWidget {
  final AsyncValue commentsAsync;

  const RoomCommentsSection({super.key, required this.commentsAsync});

  @override
  Widget build(BuildContext context) {
    return commentsAsync.when(
      data: (comments) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                comments
                    .map<Widget>((comment) => _CommentCard(comment: comment))
                    .toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (e, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Lỗi bình luận: $e"),
          ),
    );
  }
}

class _CommentCard extends StatefulWidget {
  final dynamic comment;

  const _CommentCard({required this.comment});

  @override
  State<_CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<_CommentCard> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;
    final hasLongContent = comment.noiDung.length > 100;
    final shortContent =
        hasLongContent ? comment.noiDung.substring(0, 100) : comment.noiDung;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + Name + Location
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage:
                    comment.avatar != null && comment.avatar != ''
                        ? NetworkImage(comment.avatar)
                        : null,
                child:
                    (comment.avatar == null || comment.avatar == '')
                        ? Text(comment.tenNguoiBinhLuan[0])
                        : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.tenNguoiBinhLuan,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text('Việt Nam', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Stars + Date
          Row(
            children: [
              Row(
                children: List.generate(
                  comment.saoBinhLuan,
                  (index) =>
                      const Icon(Icons.star, color: Colors.black, size: 14),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                CommentDateUtil.format(comment.ngayBinhLuan),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Nội dung
          Text(
            showMore ? comment.noiDung : shortContent,
            style: const TextStyle(fontSize: 14),
          ),
          if (hasLongContent && !showMore)
            GestureDetector(
              onTap: () => setState(() => showMore = true),
              child: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Xem thêm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
