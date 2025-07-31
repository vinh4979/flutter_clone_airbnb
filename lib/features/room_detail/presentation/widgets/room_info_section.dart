import 'package:airbnb_clone_flutter/core/utils/room_styles_util.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/guest_favorite_badge.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/host_section.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_amenities_section.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_features_section.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/widgets/room_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomInfoSection extends StatefulWidget {
  final dynamic room;
  final AsyncValue locationAsync;
  final double averageRating;
  final int totalReviews;

  const RoomInfoSection({
    super.key,
    required this.room,
    required this.locationAsync,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  State<RoomInfoSection> createState() => _RoomInfoSectionState();
}

class _RoomInfoSectionState extends State<RoomInfoSection> {
  late final String roomStyle;

  @override
  void initState() {
    super.initState();
    roomStyle = RoomStyleUtil.getRandomStyle(); // ✅ chỉ random 1 lần
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.locationAsync.valueOrNull;
    final locationName =
        location != null
            ? '${location.tenViTri}, ${location.tinhThanh}, ${location.quocGia}'
            : '';

    final roomTypeDescription =
        '${widget.room.phongNgu} phòng ngủ · $roomStyle';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoomTitleSection(
          roomName: widget.room.tenPhong,
          locationName: locationName,
          roomTypeDescription: roomTypeDescription,
          averageRating: widget.averageRating,
          totalReviews: widget.totalReviews,
        ),
        GuestFavoriteBadge(
          rating: widget.averageRating,
          totalReviews: widget.totalReviews,
        ),
        HostSection(),
        RoomAmenitiesSection(room: widget.room),
      ],
    );
  }
}
