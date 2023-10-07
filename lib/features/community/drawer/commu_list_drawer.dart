import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class CommuListDrawer extends ConsumerWidget {
  const CommuListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context,String commuid) {
    Routemaster.of(context).push('/r/$commuid');
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('Create a community'),
                leading: const Icon(Icons.add,color:Colors.black,),
                onTap: () => navigateToCreateCommunity(context),
              ),
              ListTile(
                title: const Text('Join a community'),
                leading: const Icon(Icons.group_add),
                onTap: () {
                  // Handle "Join a community" tap
                },
              ),
              ref.watch(userCommunitiesProvider).when(
                data: (communities) => Expanded(
                  child: ListView.builder(
                    itemCount: communities.length,
                    itemBuilder: (BuildContext context, int index){
                      final community = communities[index];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(community.avatar)),
                        title: Text(community.name),
                        onTap: () {navigateToCommunity(context,community.id);},
                      );
                    } ),
                ),   
                error: (error,stackTrace) => ErrorText(error: error.toString()), 
                loading: () => const Loader())
    
            ],
          ),
        ),
      ),
    );
  }
}
