
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/models/user_model.dart';
import 'package:syncoplan_project/core/providers/storage_repository_provider.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/user_profile/repository/user_profile_repositoey.dart';

final userProfileControllerProvider = StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userProfileRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return UserProfileController(
    userProfileRepository: userProfileRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});


class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editProfile({
    required File? profileFile,
    required BuildContext context,
    required String name,
  }) async {

    state = true;

    UserModel user = _ref.read(userProvider)!;
      if (profileFile != null){
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: user.uid,
        file: profileFile,
      );
      res.fold(
        (l) => showErrorSnackBar(context, l.message),
        (r) => user = user.copyWith(profilePic: r),
      );
    } 

    
    user = user.copyWith(name: name);
    
    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showErrorSnackBar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
        showSuccessSnackBar(context,"Your profile change have been succesfully save!");
      },
    );
  }
}