import 'package:airbnb_clone_flutter/features/explore/presentation/screens/explore_screen.dart';
import 'package:airbnb_clone_flutter/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:airbnb_clone_flutter/features/inbox/presentation/screens/inbox_screen.dart';
import 'package:airbnb_clone_flutter/features/profile_reactive/presentation/screen/profile_screen.dart';
import 'package:airbnb_clone_flutter/features/trips/presentation/screens/trips_screen.dart';
import 'package:airbnb_clone_flutter/providers/navigation_provider.dart';
import 'package:airbnb_clone_flutter/shared/layouts/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    /// Danh sách các màn hình cho từng tab
    final screens = <Widget Function()>[
      () => const ExploreScreen(),
      () => const FavoriteScreen(),
      () => const TripsScreen(),
      () => const InboxScreen(),
      () => const ReactiveProfileScreen(),
    ];

    return BaseScaffold(
      showAppBar: true,
      body: screens[selectedIndex](),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              offset: Offset(0, -2), // Bóng từ trên
              blurRadius: 12, // Tăng độ mờ
              spreadRadius: 1, // Làm bóng lan rộng
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            ref.read(bottomNavIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active),
              label: 'Chuyến đi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: 'Hộp thư',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Hồ sơ',
            ),
          ],
        ),
      ),
    );
  }
}
