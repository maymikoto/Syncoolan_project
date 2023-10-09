import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/commu_list_drawer.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';
import 'package:syncoplan_project/features/user_profile/screens/user_profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  static const tabWidgets = [
    UserProfileScreen(),
    UserProfileScreen(),
    UserProfileScreen(),
    UserProfileScreen(),
    // Add your main content screen here
  ];

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => displayDrawer(context),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchCommunityDelegate(ref),
              );
            },
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic),
                ),
                onPressed: () => displayEndDrawer(context),
              );
            },
          )
        ],
      ),
      body: tabWidgets[_page],
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
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
