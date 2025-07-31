import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/providers/trips_provider.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/widgets/booking_card.dart';

class TripTabView extends StatelessWidget {
  const TripTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧱 Header giống Airbnb
          Padding(
            padding: EdgeInsets.fromLTRB(24, 40, 24, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chuyến đi',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Khi bạn đặt chuyến đi, chúng sẽ hiển thị tại đây.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          // 🧱 TabBar tinh gọn
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              tabs: [Tab(text: 'Sắp tới'), Tab(text: 'Lịch sử')],
            ),
          ),

          // 🧱 Nội dung từng tab
          Expanded(
            child: TabBarView(
              children: [
                BookingListView(isUpcoming: true),
                BookingListView(isUpcoming: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingListView extends ConsumerWidget {
  final bool isUpcoming;

  const BookingListView({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(
      isUpcoming ? upcomingTripsProvider : pastTripsProvider,
    );

    if (bookings.isEmpty) {
      return const Center(
        child: Text(
          'Không có chuyến đi nào.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return BookingCard(booking: bookings[index]);
      },
    );
  }
}
