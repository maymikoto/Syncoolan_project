
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({super.key , required this.uid,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar:AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body:ref.watch(getUserDataProvider(uid)).when(
        data:(user) =>  SingleChildScrollView(
          child:Padding(
            padding:const EdgeInsets.all(18),
            child: Column(
                children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 50,
                            ),
                        ),
                  Text(user.name),
                  Text(user.email),
                  const SizedBox(height:30),
                  CustomIconTextButton(
                    text: 'Edit Profile', 
                    icon: Icons.edit, 
                    onPressed: (){}
                    ),       
                    SizedBox(height:30),                 
                        Column(
                        children: [
                          Text('Groups you manage',
                          style:Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                ],
            )),
        ), 
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader())
    );
  }
}