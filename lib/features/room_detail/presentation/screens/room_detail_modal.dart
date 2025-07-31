import 'package:airbnb_clone_flutter/core/utils/utils.dart';
import 'package:airbnb_clone_flutter/features/booking/presentation/widgets/booking_confirm_modal.dart';
import 'package:airbnb_clone_flutter/features/room_detail/domain/entities/comment.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/providers/room_detail_provider.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_comments_section.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_detail_appbar.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_detail_image_header.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_footer_booking_section.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomDetailModal extends ConsumerStatefulWidget {
  final int roomId;
  final bool isFromTrip; // 👈 thêm dòng này
  const RoomDetailModal({
    super.key,
    required this.roomId,
    this.isFromTrip = false,
  });

  @override
  ConsumerState<RoomDetailModal> createState() => _RoomDetailModalState();
}

class _RoomDetailModalState extends ConsumerState<RoomDetailModal> {
  final ScrollController _scrollController = ScrollController();
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _offset = _scrollController.offset;
      });
    });
  }

  double calculateAverageRating(List<RoomComment> comments) {
    if (comments.isEmpty) return 0;
    final totalStars = comments.fold<int>(
      0,
      (sum, comment) => sum + comment.saoBinhLuan,
    );
    return totalStars / comments.length;
  }

  int countTotalReviews(List<RoomComment> comments) {
    return comments.length;
  }

  @override
  Widget build(BuildContext context) {
    final roomDetailAsync = ref.watch(roomDetailProvider(widget.roomId));
    final commentsAsync = ref.watch(roomCommentsProvider(widget.roomId));

    return roomDetailAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (e, _) => Scaffold(
            body: Center(child: Text("Lỗi khi tải thông tin phòng: $e")),
          ),
      data: (room) {
        final locationAsync = ref.watch(roomLocationProvider(room.maViTri));

        return commentsAsync.when(
          loading:
              () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
          error:
              (e, _) => Scaffold(
                body: Center(child: Text("Lỗi khi tải bình luận: $e")),
              ),
          data: (comments) {
            final avgRating = calculateAverageRating(comments);
            final reviewCount = countTotalReviews(comments);

            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  // ✅ Ảnh trên cùng, không cuộn theo
                  RoomDetailImageHeader(
                    imageUrl: room.hinhAnh,
                    offset: _offset,
                  ),

                  // ✅ Nội dung scroll bên dưới ảnh
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 280), // Khoảng trống cho ảnh
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RoomInfoSection(
                                room: room,
                                locationAsync: locationAsync,
                                averageRating: avgRating,
                                totalReviews: reviewCount,
                              ),
                              const Divider(height: 32),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Bình luận',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              RoomCommentsSection(commentsAsync: commentsAsync),
                              const SizedBox(
                                height: 160,
                              ), // Chừa chỗ cho footer
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ AppBar nổi
                  RoomDetailAppBar(
                    offset: _offset,
                    title: room.tenPhong,
                    onBack: () => Navigator.of(context).pop(),
                  ),

                  // ✅ Footer cố định bên dưới
                  if (!widget.isFromTrip)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SafeArea(
                        top: false,
                        child: RoomBookingFooter(
                          totalPrice: room.giaTien * 2,
                          nights: 2,
                          dateRange: '29 – 31 thg 8',
                          onBookPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder:
                                  (_) => BookingConfirmModal(
                                    roomId: room.id,
                                    roomName: room.tenPhong,
                                    roomImageUrl: room.hinhAnh,
                                    roomPrice: room.giaTien,
                                    initialCheckIn: DateTime(2025, 8, 29),
                                    initialCheckOut: DateTime(2025, 8, 31),
                                    initialGuests: 2,
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
