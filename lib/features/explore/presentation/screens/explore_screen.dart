import 'dart:math';
import 'package:airbnb_clone_flutter/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/location_model.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/room_model.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_service.dart';
import 'package:airbnb_clone_flutter/shared/modals/modal_types.dart';
import 'package:airbnb_clone_flutter/shared/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _random = Random();
  final _titlePatterns = [
    "Chỗ ở được yêu thích tại",
    "Còn phòng cuối tuần ở",
    "Hôm nay tại",
    "Nơi lưu trú ở",
    "Được chọn nhiều ở",
    "Phòng còn trống tại",
    "Khách yêu thích tại",
  ];

  late Future<List<Map<String, dynamic>>> _sectionDataFuture;

  @override
  void initState() {
    super.initState();
    _sectionDataFuture = _prepareSections();
  }

  Future<List<Map<String, dynamic>>> _prepareSections() async {
    final allLocations = await ExploreRemoteDataSource().fetchLocations();
    allLocations.shuffle();

    final usedTitleIndexes = <int>{};
    final List<Map<String, dynamic>> result = [];

    for (final loc in allLocations) {
      if (result.length >= 5) break;

      final rooms = await ExploreRemoteDataSource().fetchRoomsByLocation(
        loc.id,
      );
      if (rooms.length < 5) continue;

      int titleIndex;
      do {
        titleIndex = _random.nextInt(_titlePatterns.length);
      } while (usedTitleIndexes.contains(titleIndex) &&
          usedTitleIndexes.length < _titlePatterns.length);

      usedTitleIndexes.add(titleIndex);
      final title = "${_titlePatterns[titleIndex]} ${loc.tinhThanh}";

      result.add({
        'location': loc,
        'rooms': rooms.take(5).toList(),
        'title': title,
      });
    }

    return result;
  }

  Future<void> _refresh() async {
    setState(() {
      _sectionDataFuture = _prepareSections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: InkWell(
              onTap: () {
                showAppModal(context, AppModalType.searchRooms);
              },
              borderRadius: BorderRadius.circular(32),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 12),
                    Text(
                      "Bắt đầu tìm kiếm",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _sectionDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerLoading();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Không có dữ liệu"));
            }

            final sections = snapshot.data!;

            return ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                final loc = section['location'] as LocationModel;
                final title = section['title'] as String;
                final rooms = section['rooms'] as List<RoomModel>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Title + xem tất cả
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 24, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[700],
                            ),
                            onPressed: () {
                              showAppModal(
                                context,
                                AppModalType.roomList,
                                data: {'location': loc, 'rooms': rooms},
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Danh sách phòng ngang (RoomCard)
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: rooms.length,
                        itemBuilder: (context, i) {
                          final room = rooms[i];
                          return Container(
                            margin: EdgeInsets.only(
                              left: i == 0 ? 16 : 8,
                              right: i == rooms.length - 1 ? 16 : 8,
                            ),
                            child: RoomCard(room: room),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: ShimmerWidget.rect(height: 20, width: 180),
            ),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder:
                    (_, i) => Container(
                      width: 180,
                      margin: EdgeInsets.only(
                        left: i == 0 ? 16 : 8,
                        right: i == 4 ? 16 : 8,
                      ),
                      child: Column(
                        children: [
                          ShimmerWidget.rect(
                            height: 180,
                            width: 180,
                            radius: 16,
                          ),
                          const SizedBox(height: 8),
                          ShimmerWidget.rect(height: 14, width: 160),
                          const SizedBox(height: 4),
                          ShimmerWidget.rect(height: 12, width: 140),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// 🔹 Widget shimmer đơn giản
class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerWidget.rect({
    super.key,
    required this.height,
    required this.width,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white,
        ),
      ),
    );
  }
}
