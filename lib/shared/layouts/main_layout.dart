import 'package:airbnb_clone_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:airbnb_clone_flutter/features/explore/presentation/explore_screen.dart';
import 'package:airbnb_clone_flutter/features/profile/presentation/profile_screen.dart';
import 'package:airbnb_clone_flutter/shared/bottom_sheets/register_bottom_sheet.dart';
import 'package:airbnb_clone_flutter/shared/layouts/base_scaffold.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const ExploreScreen(),
    const LoginScreen(),
    Builder(
      builder:
          (context) => Center(
            child: ElevatedButton(
              onPressed: () => showRegisterModal(context),
              child: const Text("Tạo tài khoản"),
            ),
          ),
    ),
    Center(child: Text('Inbox')),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: true,
      // title: _getTitle(_selectedIndex),
      // appBar: const ExpandableSearchAppBar(),
      body: _screens[_selectedIndex],
      // Bạn có thể bổ sung bottomNavigationBar trong BaseScaffold hoặc đặt ở đây
      // Ở đây mình đặt ngoài Scaffold để dễ custom
      // Nếu muốn gộp luôn, có thể thêm param bottomNavigationBar vào BaseScaffold
      // Mình để đây cho đơn giản
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explores'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
