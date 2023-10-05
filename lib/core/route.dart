import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/features/auth/screens/loginscreen.dart';
import 'package:syncoplan_project/features/community/screen/commu_screen.dart';
import 'package:syncoplan_project/features/community/screen/create_commu_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) => const MaterialPage(child: CreateCommunityScreen()),
});
