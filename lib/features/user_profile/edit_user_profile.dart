
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/core/widgets/text.button.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/user_profile/controller/user_profile_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
    final String uid;
  const EditProfileScreen(
   {required this.uid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {

  File? bannerFile;
  File? profileFile;


  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectProfileImage() async{
      final res = await pickImage();

        if(res!=null){
          setState(() {
            profileFile = File(res.files.first.path!);
          });
        }
    }
    
  void save() {
    ref.read(userProfileControllerProvider.notifier).editProfile(
          profileFile: profileFile,
          context: context,
          name: nameController.text.trim(),
        );
  }

 @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProfileControllerProvider);

    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: true,
            ),
            resizeToAvoidBottomInset: false,
            body:isLoading 
            ? const Loader()
            : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child:  
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('Profile Picture',style:Theme.of(context).textTheme.titleLarge),
                      const Spacer(), 
                      CustomTextButton(onTap:selectProfileImage)
                    ],),
                    const SizedBox(height: 30),
                  Center(
                    child: profileFile!=null
                       ? CircleAvatar(
                           backgroundImage: FileImage(profileFile!),
                           radius: 60,
                          )
                      : CircleAvatar(
                         backgroundImage: NetworkImage(user.profilePic),
                         radius: 60,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child:   Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black38, 
                      ),
                    ),
                     Text('Display Name',style:Theme.of(context).textTheme.titleLarge),
                     const SizedBox(height : 20),
                    TextField(
                              controller: nameController,
                              decoration: InputDecoration(

                                filled: true,
                                hintText: 'Name',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(18),
                              ),
                              maxLength: 40,
                            ),
                            const SizedBox(height : 60),
                    LongButton(
                      onTap: () => save(), 
                      labeltext: 'Save Change')  
                    ])),
            )),
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
        );
  }
}
