import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/models/commu_model.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/text.button.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String id;
  const EditCommunityScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async{
      final res = await pickImage();

        if(res!=null){
          setState(() {
            bannerFile = File(res.files.first.path!);
          });
        }
    }

  void selectProfileImage() async{
      final res = await pickImage();

        if(res!=null){
          setState(() {
            profileFile = File(res.files.first.path!);
          });
        }
    }

  void save(Community community){
    ref.read(communityControllerProvider.notifier).editCommunity(
      profileFile: profileFile, 
      bannerFile: bannerFile, 
      context: context, 
      community: community);
  }


  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch(communityControllerProvider);

    return ref.watch(getCommunityByIdProvider(widget.id)).when(
          data: (community) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit Community'),
              centerTitle: true,
            ),
            body:isLoading 
            ? const Loader()
            : Padding(
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
                         radius: 32,
                        )
                    : CircleAvatar(
                       backgroundImage: NetworkImage(community.avatar),
                       radius: 32,
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child:   Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black38, // Set the color of the line
                    ),
                  ),
                  Row(children: [
                    Text('Banner Picture',style:Theme.of(context).textTheme.titleLarge),
                    const Spacer(), 
                    CustomTextButton(onTap:selectBannerImage)
                  ],),
                  const SizedBox(height: 30),
                Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  child:bannerFile!=null 
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(bannerFile!,
                        fit: BoxFit.cover,
                      ),
                    )
                    //Image.file(bannerFile!) 
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        community.banner,
                        fit: BoxFit.cover,
                      ),
                    ),),
                  const SizedBox(height: 50,),
                  LongButton(
                    onTap: () => save(community), 
                    labeltext: 'Save Change')               
                ],
              ),
            ),
          ),
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
        );
  }
}
