
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
    final querySnapshot = await _communities
        .where('name', isEqualTo: community.name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      throw 'Community with the same name already exists!';
    }

      return right(_communities.doc(community.id).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
FutureVoid joinCommunity(String communityid,String userId) async{
      try {
        return right( _communities.doc(communityid).update({
          'members' : FieldValue.arrayUnion([userId]),
        }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }  
}

FutureVoid leaveCommunity(String communityId,String userId) async{
      try {
        return right( _communities.doc(communityId).update({
          'members' : FieldValue.arrayRemove([userId]),
        }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }  
}

Stream<List<Community>> getUserCommunities(String uid) {
    return _communities.where('members', arrayContains: uid).snapshots().map((event) {
      List<Community> communities = [];
      for (var doc in event.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

Stream<Community> getCommunityById(String id) {
    return _communities.doc(id).snapshots().map((event) => Community.fromMap(event.data() as Map<String, dynamic>));
  }


  FutureVoid editCommunity(Community community) async{
    try{
      return right( _communities.doc(community.id).update(community.toMap()));
    }on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addMods(String communityId ,List<String> uids) async{
    try{
      return right( _communities.doc(communityId).update({
        'mods':uids,
      }));
    }on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

 Stream<List<Community>> searchCommunity(String query) {
    return _communities
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<Community> communities = [];
      for (var community in event.docs) {
        communities.add(Community.fromMap(community.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

  CollectionReference get _communities => _firestore.collection(FirebaseConstants.communitiesCollection);
}