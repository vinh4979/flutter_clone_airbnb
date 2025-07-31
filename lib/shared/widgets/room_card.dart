import 'dart:math';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/screens/room_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/core/utils/utils.dart';
import 'package:airbnb_clone_flutter/core/utils/fallback_image.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/providers/liked_rooms_provider.dart';

class RoomCard extends ConsumerStatefulWidget {
  final RoomModel room;
  final double width;

  const RoomCard({super.key, required this.room, this.width = 180});

  @override
  ConsumerState<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends ConsumerState<RoomCard> {
  late final String _description;

  final _descriptions = const [
    "Toàn bộ căn hộ • 2 khách",
    "Phòng riêng • 1 giường đôi",
    "Biệt thự riêng • 4 người",
    "Studio hiện đại • 2 khách",
    "Căn hộ gần trung tâm • 3 người",
    "Nhà nguyên căn • 5 khách",
    "Phòng view đẹp • 2 người",
  ];

  @override
  void initState() {
    super.initState();
    final random = Random();
    _description = _descriptions[random.nextInt(_descriptions.length)];
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    final isLiked = ref.watch(likedRoomsProvider).contains(room.id);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => RoomDetailModal(roomId: room.id),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== IMAGE WITH SHADOW ======
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: FadeInImage(
                        placeholder: const AssetImage(
                          'assets/images/placeholder.jpg',
                        ),
                        image:
                            isValidHttpUrl(room.hinhAnh)
                                ? NetworkImage(room.hinhAnh)
                                : AssetImage(getRandomFallbackRoomImage())
                                    as ImageProvider,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (_, __, ___) {
                          return Image.asset(
                            getRandomFallbackRoomImage(),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    // 🔖 Tag "Khách yêu thích"
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                            ),
                          ],
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          "Khách yêu thích",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),

                    // ❤️ Icon yêu thích
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap:
                            () => ref
                                .read(likedRoomsProvider.notifier)
                                .toggleLike(room.id),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 22,
                              color:
                                  isLiked
                                      ? Colors.white
                                      : Colors.black.withValues(alpha: 0.4),
                            ),
                            const Icon(
                              Icons.favorite_border,
                              size: 22,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              room.tenPhong,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 2),

            Text(
              _description,
              style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
            ),

            const SizedBox(height: 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatRoomPrice(room.giaTien),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF444444),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 13, color: Color(0xFF777777)),
                    const SizedBox(width: 4),
                    Text(
                      genRandomRating(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
