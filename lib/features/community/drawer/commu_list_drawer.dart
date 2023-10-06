import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class CommuListDrawer extends ConsumerWidget {
  const CommuListDrawer({Key? key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context,Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text('Create a community'),
                leading: Icon(Icons.add),
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
                        title: Text('${community.name}'),
                        onTap: () {navigateToCommunity(context, community);},
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
