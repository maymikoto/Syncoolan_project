
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/theme/theme.dart';

class AddPostScreen extends ConsumerWidget {
 final String id;
  const AddPostScreen({ required this.id, super.key});

/*
  void navigateToType(BuildContext context,String type){
    Routemaster.of(context).push('/add-post/$type');
  }
*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final user = ref.watch(userProvider)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.send, color: Colors.white),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(children: [
                        CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 30,
                      ), 
                      const SizedBox(width: 20,),
                        Container(
                          padding: EdgeInsets.all(12),
                         decoration: BoxDecoration(
                            color: Colors.blue.shade100, // Background color
                            borderRadius: BorderRadius.circular(18.0), // Rounded corners
                            ),
                          child: Text(user.name,
                            style:TextStyle(
                              color:Colors.blue.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              )),
                        )]),
                    const SizedBox(height: 30),
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
    );
  }
}