import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/models/post_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/features/post/repository/post_repository.dart';
import 'package:syncoplan_project/features/user_profile/controller/user_profile_controller.dart';
import 'package:uuid/uuid.dart';



final postControllerProvider = StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final userPostsProvider = StreamProvider.family<List<Post>, List<Community>>((ref, communities) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchUserPosts(communities);
});

final getPostByIdProvider = StreamProvider.family<Post, String>((ref, postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPostById(postId);
});


class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createPost({
    required BuildContext context,
    required String content,
    required String cid,
    File? image

  }) async {
    state = true;
    final user = _ref.read(userProvider)!;
    String postId = const Uuid().v1();
    final community = _ref.read(communityControllerProvider.notifier)!;
    final imageRes = await _storageRepository.storeFile(
      path: 'posts/${community}',
      id: postId,
      file: image,
    );
   imageRes.fold((l) => showErrorSnackBar(context, l.message), (r) async {
      final Post post = Post(
      postId: postId,
      authorId: user.uid,
      content: content,
      communityId:cid,
      postDate: DateTime.now(),
      likes: [],
      imageUrls: r,
      linkedEventId: '',
    );

      final res = await _postRepository.addPost(post);
      state = false;
      res.fold((l) => showErrorSnackBar(context, l.message), (r) {
        showSuccessSnackBar(context, 'Posted successfully!');
        Routemaster.of(context).pop();
      });
    });
  }


  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    if (communities.isNotEmpty) {
      return _postRepository.fetchUserPosts(communities);
    }
    return Stream.value([]);
  }

  void deletePost(Post post, BuildContext context) async {
    final res = await _postRepository.deletePost(post);
    _ref.read(userProfileControllerProvider.notifier);
    res.fold((l) => null, (r) => showErrorSnackBar(context, 'Post Deleted successfully!'));
  }

  void like(Post post) async {
    final uid = _ref.read(userProvider)!.uid;
    _postRepository.upvote(post, uid);
  }

  Stream<Post> getPostById(String postId) {
    return _postRepository.getPostById(postId);
  }
}
