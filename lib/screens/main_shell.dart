import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'my_announcements_screen.dart';
import 'profile_screen.dart';

/// Holds the bottom navigation bar and switches between the three tabs.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          // Not const, so these tabs rebuild with fresh data on tab switch.
          // ignore: prefer_const_constructors
          HomeScreen(),
          // ignore: prefer_const_constructors
          MyAnnouncementsScreen(),
          ProfileScreen(onMyAnnouncements: () => setState(() => _index = 1)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'My Announcements',
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
