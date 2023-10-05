import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';

class CommuListDrawer extends ConsumerWidget {
  const CommuListDrawer({Key? key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Create a community'),
              leading: Icon(Icons.add),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ListTile(
              title: Text('Join a community'),
              leading: Icon(Icons.group_add),
              onTap: () {
                // Handle "Join a community" tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
