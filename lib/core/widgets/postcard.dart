import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/models/post_model.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/post/controller/post_controller.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({
    super.key,
    required this.post,
  });

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void upvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).like(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use AsyncValue<UserModel> to get user data
    final userAsyncValue = ref.watch(getUserDataProvider(post.authorId));
    
    // Check the state of AsyncValue
    return userAsyncValue.when(
      data: (user) {
        // User data is available, you can access properties like profilePic
        return Card(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic), // Access profilePic here
                ),
                title: Text(user.name),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  post.content,
                  style: const TextStyle(fontSize: 16.0),
                  softWrap: true,
                ),
              ),
              if (post.imageUrls != '')
                SizedBox(
                  height: 250,
                  child: Image.network(
                    post.imageUrls,
                    fit: BoxFit.contain,
                  ),
                ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    label: const Text('Love'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.comment),
                    label: const Text('Comment'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () {
        // Handle loading state, you can return a loading indicator or placeholder here
        return const Loader();
      },
      error: (error, stackTrace) {
        // Handle error state, you can return an error message or retry button here
        return Text('Error: $error');
      },
    );
  }
}
