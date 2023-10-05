import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/core/widgets/signin_button.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isLoading = ref.watch(AuthControllerProvider);
    return  Scaffold(
      body: isLoading 
        ? const Loader()  
        : SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              "Welcome to SyncoPlan",
              style:Theme.of(context).textTheme.labelSmall
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(Constants.loginEmotePath,height:400,),
              ),
              const SizedBox(height: 30),
              SignInButton()
          ],
        ),
      ),
    );
  }
}
