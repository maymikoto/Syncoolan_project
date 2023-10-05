import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/features/auth/screens/loginscreen.dart';
import 'package:syncoplan_project/features/home/screen/home_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen())
});