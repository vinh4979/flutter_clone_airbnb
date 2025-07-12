import 'package:airbnb_clone_flutter/models/room/room_modal.dart';
import 'package:airbnb_clone_flutter/shared/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/shared/widgets/sroll_list_horizontal.dart';

class RoomSectionModel {
  final String title;
  final List<RoomModel> rooms;

  RoomSectionModel({required this.title, required this.rooms});
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final luxuryRooms = [
      RoomModel(
        title: 'Villa biển',
        price: 'đ2.000.000',
        rating: 4.8,
        imageUrl:
            'https://www.kientrucapollo.vn/uploads/46/khach-san/3-ks-5-sao-tai-hn/top-3-khach-san-5-sao-dep-tai-ha-noi-1.jpg',
        tag: 'Được yêu thích',
      ),
      RoomModel(
        title: 'Villa biển',
        price: 'đ2.000.000',
        rating: 4.8,
        imageUrl:
            'https://www.kientrucapollo.vn/uploads/46/khach-san/3-ks-5-sao-tai-hn/top-3-khach-san-5-sao-dep-tai-ha-noi-1.jpg',
      ),
      RoomModel(
        title: 'Villa biển',
        price: 'đ2.000.000',
        rating: 4.8,
        imageUrl:
            'https://www.kientrucapollo.vn/uploads/46/khach-san/3-ks-5-sao-tai-hn/top-3-khach-san-5-sao-dep-tai-ha-noi-1.jpg',
      ),
    ];

    final budgetRooms = [
      RoomModel(
        title: 'Phòng trọ Hà Nội',
        price: 'đ400.000',
        rating: 4.2,
        imageUrl:
            'https://www.kientrucapollo.vn/uploads/46/khach-san/3-ks-5-sao-tai-hn/top-3-khach-san-5-sao-dep-tai-ha-noi-1.jpg',
      ),
    ];

    final trendingRooms = [
      RoomModel(
        title: 'Studio Đà Lạt',
        price: 'đ1.100.000',
        rating: 4.7,
        imageUrl:
            'https://www.kientrucapollo.vn/uploads/46/khach-san/3-ks-5-sao-tai-hn/top-3-khach-san-5-sao-dep-tai-ha-noi-1.jpg',
      ),
    ];

    final sections = [
      RoomSectionModel(title: 'Phòng sang trọng', rooms: luxuryRooms),
      RoomSectionModel(title: 'Phòng giá rẻ', rooms: budgetRooms),
      RoomSectionModel(title: 'Đang được quan tâm', rooms: trendingRooms),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Khám phá')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ...sections.map(
              (section) => Column(
                children: [
                  ScrollListRoom(
                    title: section.title,
                    listRoomWidgets:
                        section.rooms
                            .map((room) => RoomCardWidget(room: room))
                            .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
