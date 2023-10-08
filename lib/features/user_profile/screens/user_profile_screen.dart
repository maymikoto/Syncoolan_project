import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncoplan_project/core/widgets/button.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';
import 'package:syncoplan_project/theme/theme.dart';
import 'package:line_icons/line_icons.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({Key? key, required this.uid}) : super(key: key);

void navigateToCommunity(BuildContext context, String commuid) {
      Routemaster.of(context).push('/r/$commuid');
    }

  void navigateToEditUser(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              ref.watch(getUserDataProvider(uid)).when(data:(user) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 50,
                    ),
                    const SizedBox(width: 30,),
                    Column(
                      children: [
                        Text(user.name, style: headline1),
                        Text(user.email, style: headline2),
                      ],
                    ),
                  ],
                );
              }, error: (error, stackTrace) {
                return ErrorText(error: error.toString());
              }, loading: () {
                return const Loader();
              }),
              const SizedBox(height: 30),
              CustomIconTextButton(
                text: 'Edit Profile',
                icon: Icons.edit,
                onPressed: () => navigateToEditUser(context),
              ),
              const SizedBox(height: 30),
              const Divider(height: 1.0,thickness:0.5,color:Colors.black26,),
              const SizedBox(height: 10),
                  const ListTile(
                      leading:Icon(Icons.group,color:Colors.black,),
                      title:Text("Groups you've joined", style:TextStyle(fontWeight: FontWeight.w600)) ,
                  ),
              ref.watch(userCommunitiesProvider).when(
                data: (communities) {
                  return  communities.isNotEmpty? ListView.builder(
                    shrinkWrap: true, 
                    itemCount: communities.length,
                    itemBuilder:(BuildContext context, int index) {
                      final community = communities[index];
                      return
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(20),
                                  ),
                                child: ListTile(
                                  tileColor: Colors.blue.shade50,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(community.avatar),
                                  ),
                                  title: Text(community.name ,style: TextStyle(fontSize: 16,color:Colors.blue.shade600,fontWeight: FontWeight.w600),),
                                  onTap: () {
                                    navigateToCommunity(context, community.id);
                                  },
                                ),
                      ),
                      const Divider()
                            ],
                        );
                    },
                  )
                  :
                  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LineIcon(LineIcons.timesCircle ,color:Color.fromARGB(115, 178, 178, 178),size: 140,),
                        Text("Group Not Found",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(115, 178, 178, 178)
                        ),),
                        Text("Please create or join a community.",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(115, 178, 178, 178)
                        ),)                        
                      ],
                  );

                },
                error: (error, stackTrace) {
                  return ErrorText(error: error.toString());
                },
                loading: () {
                  return const Loader();
                },
              ),
              const SizedBox(height: 18),
      
            ],
          ),
        ),
      ),
    );
  }
}
