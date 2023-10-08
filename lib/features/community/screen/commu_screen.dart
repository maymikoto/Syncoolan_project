import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floating_navigation_bar/floating_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/commu_list_drawer.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';
import 'package:syncoplan_project/theme/theme.dart';

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
            return IconButton(icon:const Icon(Icons.menu),
            onPressed:() => displayDrawer(context), 
            );
          }
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.search),
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
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
     bottomNavigationBar: CurvedNavigationBar(
      color: Colors.deepPurple.shade600,
      backgroundColor: Colors.white,
      height: 60,
    items: const [
      CurvedNavigationBarItem(
        child: Icon(EvaIcons.home,color:Colors.white,),
        label: 'Home',
        labelStyle: TextStyle(color: Colors.white,fontSize:10)
      ),
      CurvedNavigationBarItem(
        child: Icon(Icons.people_alt ,color:Colors.white,),
        label: 'Community',
        labelStyle: TextStyle(color: Colors.white,fontSize:10)
      ),
      CurvedNavigationBarItem(
        child: Icon(Icons.calendar_month_rounded ,color:Colors.white,),
        label: 'Calendar',
        labelStyle: TextStyle(color: Colors.white,fontSize:10)        
      ),
      CurvedNavigationBarItem(
        child: Icon(EvaIcons.person ,color:Colors.white,),
        label: 'Profile',
        labelStyle: TextStyle(color: Colors.white,fontSize:10)       
      ),

  ]));
  }
}