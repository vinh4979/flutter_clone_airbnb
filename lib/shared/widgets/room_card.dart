import 'package:airbnb_clone_flutter/models/room/room_modal.dart';
import 'package:airbnb_clone_flutter/shared/widgets/like.dart';
import 'package:airbnb_clone_flutter/shared/widgets/tag.dart';
import 'package:flutter/material.dart';

class RoomCardWidget extends StatelessWidget {
  final RoomModel room;

  const RoomCardWidget({super.key, required this.room}); // constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 240,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            // Ảnh chiếm 2/3 (flex: 3)
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Ảnh nền
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    child: Image.network(
                      room.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),

                  // Phần chứa Tag và Like với viền đỏ để debug
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child:
                                room.tag != null
                                    ? TagWidget(label: room.tag!)
                                    : const SizedBox(width: 60),
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: LikeButtonWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Nội dung chiếm 1/3 (flex: 1)
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      room.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.75,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          room.price,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              room.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
