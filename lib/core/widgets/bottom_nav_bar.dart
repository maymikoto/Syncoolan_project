import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/screens/calendar_screen.dart';
import 'package:syncoplan_project/features/community/screen/commu_main_screen.dart';
import 'package:syncoplan_project/features/community/screen/commu_page.dart';
import 'package:syncoplan_project/features/home/screens/home_screen.dart';
import 'package:syncoplan_project/features/user_profile/screens/user_profile_screen.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int _page = 0;

  static const tabWidgets = [
    HomeScreen(),
    CommunityHomeScreen(),
    CaledndarScreen(),
    UserProfileScreen(),
    // Add your main content screen here
  ];

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: tabWidgets[_page],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple.shade200,
        backgroundColor: Colors.white,
        height: 60,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(
              EvaIcons.home,
              color: Colors.white,
            ),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.people_alt,
              color: Colors.white,
            ),
            label: 'Community',
            labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
            ),
            label: 'Calendar',
            labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              EvaIcons.person,
              color: Colors.white,
            ),
            label: 'Profile',
            labelStyle: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
        onTap: onPageChanged,
        index: _page,
      ),
    );
  }
}
