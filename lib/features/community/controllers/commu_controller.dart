import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/repository/commu_repository.dart';

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

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref.watch(communityControllerProvider.notifier).getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
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
      id: name,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarGroupDefault,
      members: [uid],
      mods: [uid],
    );

   final res = await _communityRepository.createCommunity(community);  
   state = false;
  
  res.fold((l) => showSnackBar(context,l.message), 
  (r) {
    showSnackBar(context,'Community created successfuly!');
    Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name); // Corrected method name
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
      id: community.name,
      file: profileFile,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
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
      id: community.name,
      file: bannerFile,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
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
    (l) => showSnackBar(context, l.message),
    (r) => Routemaster.of(context).pop(),
  );
  }
   Stream<List<Community>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }
 
}



