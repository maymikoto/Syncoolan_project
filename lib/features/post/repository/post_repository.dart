
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncoplan_project/core/constants/firebase_constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/models/post_model.dart';
import 'package:syncoplan_project/core/providers/firebase_providers.dart';
import 'package:syncoplan_project/core/type_defs.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _posts => _firestore.collection(FirebaseConstants.postsCollection);
  CollectionReference get _comments => _firestore.collection(FirebaseConstants.commentsCollection);
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.postId).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    return _posts
        .where('communityName', whereIn: communities.map((e) => e.name).toList())
        .orderBy('postDate', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }


  FutureVoid deletePost(Post post) async {
    try {
      return right(_posts.doc(post.postId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void upvote(Post post, String userId) async {

    if (post.likes.contains(userId)) {
      _posts.doc(post.postId).update({
        'upvotes': FieldValue.arrayRemove([userId]),
      });
    } else {
      _posts.doc(post.postId).update({
        'upvotes': FieldValue.arrayUnion([userId]),
      });
    }
  }


  Stream<Post> getPostById(String postId) {
    return _posts.doc(postId).snapshots().map((event) => Post.fromMap(event.data() as Map<String, dynamic>));
  }
  
}