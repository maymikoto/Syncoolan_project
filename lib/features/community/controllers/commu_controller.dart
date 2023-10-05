import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/repository/commu_repository.dart';

final communityControllerProvider = StateNotifierProvider<CommunityController,bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunityController(communityRepository: communityRepository, ref: ref);
});


class CommunityController extends StateNotifier<bool>{
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
  }): _communityRepository = communityRepository,
      _ref = ref,
      super(false);


  void createCommunity(String name,BuildContext context) async{
   
   state = true;
   final uid = _ref.read(userProvider)?.uid ?? '';

    Community community = Community(
      id: name, 
      name: name, 
      banner: Constants.bannerDefault, 
      members: [uid], 
      mods: [uid]);


   final res = await _communityRepository.createCommunity(community);  
   state = false;
  
  res.fold((l) => showSnackBar(context,l.message), 
  (r) {
    showSnackBar(context,'Community created successfuly!');
    Routemaster.of(context).pop();
    });
  }
}