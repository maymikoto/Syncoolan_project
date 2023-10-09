import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/models/comment.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/models/post_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/post/repository/post_repository.dart';
import 'package:syncoplan_project/features/user_profile/controller/user_profile_controller.dart';



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

final getPostCommentsProvider = StreamProvider.family<List<Comment>, String>((ref, postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchPostComments(postId);
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
    required Community selectedCommunity,
    required String description,
  }) async {
    state = true;
    final user = _ref.read(userProvider)!;

    final Post post = Post(
      authorId: user.uid,
      content: content,
      communityId: selectedCommunity.id,
      postDate: DateTime.now(),
      likes: [],
      comments: [],
      imageUrls: [],
      linkedEventId: '',
    );

    final res = await _postRepository.addPost(post);
    _ref.read(userProfileControllerProvider.notifier);
    state = false;
    res.fold((l) => showErrorSnackBar(context, l.message), (r) {
      showSuccessSnackBar(context, 'Posted successfully!');
      Routemaster.of(context).pop();
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

  void addComment({
    required BuildContext context,
    required String text,
    required Post post,
  }) async {
    final user = _ref.read(userProvider)!;
    Comment comment = Comment(
      authorId: user.uid,
      postId: post.postId,
      commentContent: text,
      commentDate: DateTime.now(),
    );
    final res = await _postRepository.addComment(comment);
    _ref.read(userProfileControllerProvider.notifier);
    res.fold((l) => showErrorSnackBar(context, l.message), (r) => null);
  }

  Stream<List<Comment>> fetchPostComments(String postId) {
    return _postRepository.getCommentsOfPost(postId);
  }
}
