import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/features/auth/screens/loginscreen.dart';
import 'package:syncoplan_project/features/community/screen/add_mods_screen.dart';
import 'package:syncoplan_project/features/community/screen/commu_page.dart';
import 'package:syncoplan_project/features/community/screen/commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/create_commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/edit_commu.dart';
import 'package:syncoplan_project/features/community/screen/mod_tools_screen.dart';
import 'package:syncoplan_project/features/post/screens/add_post.dart';
import 'package:syncoplan_project/features/post/screens/add_post_type_screen.dart';
import 'package:syncoplan_project/features/user_profile/edit_user_profile.dart';
import 'package:syncoplan_project/features/user_profile/screens/user_profile_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen()),
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
   '/add-post': (route) =>  const MaterialPage(
          child: AddPostScreen(),
        ),
    '/add-post/:type': (routeData) => MaterialPage(
          child: AddModsScreen(
            id: routeData.pathParameters['id']!,
          ),
      ),               
});
