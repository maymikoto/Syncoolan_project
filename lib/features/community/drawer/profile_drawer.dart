
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

void logOut(WidgetRef ref){
  ref.read(AuthControllerProvider.notifier).logOut();
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:Column(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 40,
            ),
            const SizedBox(height: 30,),
            Text(user.name),
            const SizedBox(height: 30,),
            const Divider(),
            ListTile(
                title: const Text('My Profile'),
                leading: const Icon(Icons.person,color: Colors.black,),
                onTap: () {},
           ),
            ListTile(
                title: const Text('Log Out'),
                leading: const Icon(Icons.logout_rounded,color:Colors.red,),
                onTap: () => logOut(ref),
           ),
             
          ],) ),
      ),
    );
  }
}