import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/commu_list_drawer.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

void displayDrawer(BuildContext context){
  Scaffold.of(context).openDrawer();
}

void displayEndDrawer(BuildContext context){
  Scaffold.of(context).openEndDrawer();
}

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        centerTitle:false,
        leading: Builder(
          builder: (context) {
            return IconButton(icon:Icon(Icons.menu),
            onPressed:() => displayDrawer(context), 
            );
          }
        ),
        actions: [
          IconButton(
            icon:Icon(Icons.search),
            onPressed: () {showSearch(context: context, delegate: SearchCommunityDelegate(ref));},
          ),          
          Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(backgroundImage: NetworkImage(user.profilePic)),
                onPressed: () => displayEndDrawer(context),
              );
            }
          )
        ],
      ),
      drawer: CommuListDrawer(),
      endDrawer: ProfileDrawer(),
      );
  }
}