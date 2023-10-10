import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/features/auth/screens/loginscreen.dart';
import 'package:syncoplan_project/features/calendar/screens/add_calendar_screen.dart';
import 'package:syncoplan_project/features/community/screen/add_mods_screen.dart';
import 'package:syncoplan_project/features/community/screen/commu_page.dart';
import 'package:syncoplan_project/core/widgets/bottom_nav_bar.dart';
import 'package:syncoplan_project/features/community/screen/create_commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/edit_commu.dart';
import 'package:syncoplan_project/features/community/screen/mod_tools_screen.dart';
import 'package:syncoplan_project/features/post/screens/add_post.dart';
import 'package:syncoplan_project/features/user_profile/screens/edit_user_profile.dart';
import 'package:syncoplan_project/features/user_profile/screens/user_profile_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: BottomNavBar()),
  '/create-community': (_) => const MaterialPage(child: CreateCommunityScreen()),
  '/r/:id': (route) => MaterialPage(
      child: CommunityScreen(
      id: route.pathParameters['id']!,
        ),),
    '/mod-tools/:id': (routeData) => MaterialPage(
          child: ModToolsScreen(
            id: routeData.pathParameters['id']!,
          ),), 
    '/edit-community/:id': (routeData) => MaterialPage(
          child: EditCommunityScreen(
            id: routeData.pathParameters['id']!,
          ),
        ),   
    '/add-mods/:id': (routeData) => MaterialPage(
          child: AddModsScreen(
            id: routeData.pathParameters['id']!,
          ),
        ), 
    '/profile': (_) => const MaterialPage(
          child: UserProfileScreen(),
        ),
    '/edit-profile/:uid': (routeData) => MaterialPage(
          child: EditProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
   '/add-post/:id': (routeData) => MaterialPage(
          child: AddPostScreen(
            id: routeData.pathParameters['id']!,
          ),
        ),
  '/add-event/:id': (routeData) => MaterialPage(
          child: AddCalendarScreen(
            id: routeData.pathParameters['id']!,
          ),
      ),           
});

