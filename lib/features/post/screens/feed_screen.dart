
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/core/widgets/postcard.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';


class FeedScreen extends ConsumerWidget {
  final String id;
  const FeedScreen({required this.id, super.key, });

  void navigateToAddPost (BuildContext context) {
    Routemaster.of(context).push('/add-post/$id');
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final user = ref.watch(userProvider)!;

      return Scaffold(
        body:ref.watch(getCommunityPostsProvider(id)).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final post = data[index];
                          return PostCard(post: post);
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return ErrorText(error: error.toString());
                    },
                    loading: () => const Loader(),
                  ),
            floatingActionButton: ref.watch(getCommunityByIdProvider(id)).when(
    data: (community) => community.members.contains(user.uid)?
      FloatingActionButton(
          onPressed: () => navigateToAddPost(context),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add_box),
        ) : null, error: (error, stackTrace) => ErrorText(error: error.toString()),loading: () => const Loader(),
  )
          );
  }
}