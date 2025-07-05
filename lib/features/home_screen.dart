import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/features/watch/watch_vu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  void _onIndexSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 75,
      color: AppColors.backgroundColor,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(27),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onIndexSelected,
          items: [
            _navigationItem(label: 'Dashboard', icon: 'dashboard', index: 0),
            _navigationItem(label: 'Watch', icon: 'watch', index: 1),
            _navigationItem(
              label: 'Media Library',
              icon: 'media_library',
              index: 2,
            ),
            _navigationItem(label: 'More', icon: 'more', index: 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navigationItem({
    required String label,
    required String icon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/icons/$icon.png',
        color: index == _selectedIndex ? Colors.white : AppColors.grayColor,
      ),
      label: label,
    );
  }

  final List<Widget> _pages = [
    Center(child: Text('Dashboard')),
    WatchView(),
    Center(child: Text('Media Library')),
    Center(child: Text('More')),
  ];
}
