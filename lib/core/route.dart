import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/features/auth/screens/loginscreen.dart';
import 'package:syncoplan_project/features/community/screen/add_mods_screen.dart';
import 'package:syncoplan_project/features/community/screen/commu_page.dart';
import 'package:syncoplan_project/features/community/screen/commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/create_commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/edit_commu.dart';
import 'package:syncoplan_project/features/community/screen/mod_tools_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) => const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
      child: CommunityScreen(
      name: route.pathParameters['name']!,
        ),),
    '/mod-tools/:name': (routeData) => MaterialPage(
          child: ModToolsScreen(
            name: routeData.pathParameters['name']!,
          ),), 
    '/edit-community/:name': (routeData) => MaterialPage(
          child: EditCommunityScreen(
            name: routeData.pathParameters['name']!,
          ),
        ),   
    '/add-mods/:name': (routeData) => MaterialPage(
          child: AddModsScreen(
            name: routeData.pathParameters['name']!,
          ),
        ), 
});
