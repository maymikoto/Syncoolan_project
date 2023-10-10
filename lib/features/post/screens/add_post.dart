import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/util.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/post/controller/post_controller.dart';

class AddPostScreen extends ConsumerStatefulWidget {
   final String id;
  const AddPostScreen({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {

File? postPicFile;

late TextEditingController _postController = TextEditingController();

 void selectPostImage() async{
      final res = await pickImage();
        if(res!=null){
          setState(() {
            postPicFile = File(res.files.first.path!);
          });


        }
    }

  void save() {
    ref.read(postControllerProvider.notifier).createPost(
          content:_postController.text.trim(),
          cid: widget.id,
          image: postPicFile,
          context: context         
        );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () => save(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                    radius: 30,
                  ),
                  const SizedBox(width: 20,),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      user.name,
                      style: TextStyle(
                        color: Colors.blue.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
               Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none,
                      ),
                    ),
        if (postPicFile != null)
          Container(
              height: 250, // Set the desired height
              child: Image.file(
                postPicFile!,
                fit: BoxFit.contain, // Maintain aspect ratio and fit entirely within the container
              ),
            ),
                  ]))),
                  const Divider(height: 1.0, thickness: 0.5, color: Colors.black26,),
                  const SizedBox(height: 20),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  tileColor: const Color.fromARGB(59, 199, 231, 255),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: const Icon(EvaIcons.image, color: Colors.green,),
                  title: Text("Add Picture", style: TextStyle(fontSize: 16, color: Colors.blue.shade600, fontWeight: FontWeight.w600),),
                  onTap:selectPostImage,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  tileColor: const Color.fromARGB(59, 199, 231, 255),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: const Icon(EvaIcons.calendar, color: Colors.purple,),
                  title: Text("Link To Event", style: TextStyle(fontSize: 16, color: Colors.blue.shade600, fontWeight: FontWeight.w600),),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
