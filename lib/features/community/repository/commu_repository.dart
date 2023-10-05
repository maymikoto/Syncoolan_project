
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:syncoplan_project/core/constants/firebase_constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/providers/firebase_providers.dart';
import 'package:syncoplan_project/core/type_defs.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Community with the same name already exists!';
      }

      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  CollectionReference get _communities => _firestore.collection(FirebaseConstants.communitiesCollection);
}