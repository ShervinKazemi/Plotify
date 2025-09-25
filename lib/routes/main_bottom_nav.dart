import 'package:flutter/material.dart';
import 'package:plotify/features/home/home_page.dart';
import 'package:plotify/features/profile/profile_page.dart';
import 'package:plotify/features/watchlist/watchlist_page.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int selectedIndex = 0;

  void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> widgets = [
    const HomePage(),
    const WatchlistPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      body: widgets[selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 32),
        decoration: BoxDecoration(
          color: Color(0xFF26253A),
          borderRadius: BorderRadius.circular(24)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(theme, Icons.home, "Home", 0),
            _buildNavItem(theme, Icons.favorite, "Watchlist", 1),
            _buildNavItem(theme, Icons.person, "Profile", 2)
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(ThemeData theme, IconData icon, String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        updateIndex(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 1.0, end: isSelected ? 1.1 : 1.0),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                      size: isSelected ? 28 : 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                      fontSize: isSelected ? 14 : 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    child: Text(text),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
