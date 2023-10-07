// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/theme/theme.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(children: [
                        CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 50,
                      ), 
                      const Spacer(),
                    Column(
                      children: [
                        Text(user.name,style:headline1,), 
                        Text(user.email,style:headline2),
                      ],
                    )                                     
                    ],),
                    const SizedBox(height: 30),
                    CustomIconTextButton(
                      text: 'Edit Profile',
                      icon: Icons.edit,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 1.0,thickness:0.5,color:Colors.black26,),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Groups ',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),   
                          const SizedBox(height:10),                       
                          Text(
                            "Groups you're admin",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          // Add your group management related widgets here
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
