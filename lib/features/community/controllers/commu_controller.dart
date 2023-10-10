import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/core/failure.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/models/event_model.dart';
import 'package:syncoplan_project/core/models/post_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/calendar/controller/event_controller.dart';
import 'package:syncoplan_project/features/community/repository/commu_repository.dart';


final communityProvider = StateProvider<Community?>((ref) => null);

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

final communityControllerProvider = StateNotifierProvider<CommunityController,bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  
  return CommunityController(
    communityRepository: communityRepository, 
    ref: ref,
    storageRepository: storageRepository
    );
});

final getCommunityByIdProvider = StreamProvider.family((ref, String id) {
  return ref.watch(communityControllerProvider.notifier).getCommunityById(id);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

final getCommunityPostsProvider = StreamProvider.family((ref, String id) {
  return ref.read(communityControllerProvider.notifier).getCommunityPosts(id);
});

final communityEventsProvider = StreamProvider.family<List<EventModel>, String>((ref, communityId) {
  final eventController = ref.watch(eventControllerProvider.notifier);
  return eventController.getCommunityEventsAsStream(communityId); // Use the new stream method
});



class CommunityController extends StateNotifier<bool>{
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    required StorageRepository storageRepository
  }): _communityRepository = communityRepository,
      _ref = ref,
      _storageRepository = storageRepository,
      super(false);


  void createCommunity(String name,BuildContext context) async{
   
   state = true;
   final uid = _ref.read(userProvider)?.uid ?? '';

    Community community = Community(
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarGroupDefault,
      members: [uid],
      mods: [uid],
    );

   final res = await _communityRepository.createCommunity(community);  
   state = false;
  
  res.fold((l) => showErrorSnackBar(context,l.message), 
  (r) {
    showSuccessSnackBar(context,'Community created successfuly!');
    Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityById(String id) {
    return _communityRepository.getCommunityById(id); // Corrected method name
  }

void editCommunity({
  required File? profileFile,
  required File? bannerFile,
  required BuildContext context,
  required Community community,
}) async {
  state = true;

  // Check and update the profile picture
  if (profileFile != null) {
    final res = await _storageRepository.storeFile(
      path: 'communities/profile',
      id: community.id,
      file: profileFile,
    );
    res.fold(
      (l) => showErrorSnackBar(context, l.message),
      (r) {
        // Update the community's avatar URL
        community = community.copyWith(avatar: r);
      },
    );
  }

  // Check and update the banner picture
  if (bannerFile != null) {
    final res = await _storageRepository.storeFile(
      path: 'communities/banner',
      id: community.id,
      file: bannerFile,
    );
    res.fold(
      (l) => showErrorSnackBar(context, l.message),
      (r) {
        // Update the community's banner URL
        community = community.copyWith(banner: r);
      },
    );
  }

  state = false;

  // Update the community in Firestore with the new image URLs
  final res = await _communityRepository.editCommunity(community);
  state = false;
  
  res.fold(
    (l) => showErrorSnackBar(context, l.message),
    (r) => showSuccessSnackBar(context,'Your edited community profile has been successfully saved.'),
  );
}

  void joinCommunity(Community community, BuildContext context) async{
    final user = _ref.read(userProvider)!;

    Either<Failure, void> res;
    if (community.members.contains(user.uid)) {
      res = await _communityRepository.leaveCommunity(community.id, user.uid);
    } else {
      res = await _communityRepository.joinCommunity(community.id, user.uid);
    }

    res.fold((l) => showErrorSnackBar(context, l.message), (r) {
      if (community.members.contains(user.uid)) {
        showSuccessSnackBar(context, 'Community left successfully!');
      } else {
        showSuccessSnackBar(context, 'Community joined successfully!');
      }
    });
  }
 
   Stream<List<Community>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }

void addMods(String communityid ,List<String> uids,BuildContext context) async{
  final res = await _communityRepository.addMods(communityid,uids);
  res.fold(
    (l) => showErrorSnackBar(context,l.message), 
    (r) => showSuccessSnackBar(context,'Mods updated successfully!'),);
}

  Stream<List<Post>> getCommunityPosts(String id) {
    return _communityRepository.getCommunityPosts(id);
  }
  
  Stream<List<EventModel>> getCommunityEvents(String communityId) {
  return _communityRepository.getCommunityEvents(communityId);
}

  
}




