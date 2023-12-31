// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/models/user_model.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/features/auth/repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);


final AuthControllerProvider = StateNotifierProvider<AuthController,bool>(
  (ref) => AuthController(
  authRepository:ref.watch(authRepositoryProvider),
  ref: ref,
  )
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref,String uid) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository,required Ref ref}) 
  : _authRepository = authRepository,
    _ref = ref, 
    super(false) ;

Stream<User?> get authStateChange => _authRepository.authStateChange;
 
void signInWithGoogle(BuildContext context) async{
  state = true;
  final user = await _authRepository.signInWithGoogle();
  state = false;
  user.fold(
      (l) => showErrorSnackBar(context,l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel)  
    );
  }

  Stream<UserModel>getUserData(String uid){
    return _authRepository.getUserData(uid);
  }

  void logOut(){
    _authRepository.logOut();
  }
}