import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/community/delegates/search_community_delegate.dart';
import 'package:syncoplan_project/features/community/drawer/commu_list_drawer.dart';
import 'package:syncoplan_project/features/community/drawer/profile_drawer.dart';

class CommunityHomeScreen extends ConsumerWidget {
  const CommunityHomeScreen({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.id}');
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a community'),
              leading: const Icon(Icons.add),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
              data: (communities) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: communities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final community = communities[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(community.avatar),
                      ),
                      title: Text(community.name),
                      onTap: () {
                        navigateToCommunity(context, community);
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            ),
          ],
        ),
      ),
    );
  }
}
