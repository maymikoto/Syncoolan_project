
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';

class CaledndarScreen extends ConsumerWidget {
  const CaledndarScreen({super.key});


  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final  uid = user.uid;
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: false,
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
      endDrawer: const ProfileDrawer(),
    );
  }
}
