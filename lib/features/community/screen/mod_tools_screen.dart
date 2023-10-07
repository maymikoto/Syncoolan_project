
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String id;
  const ModToolsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$id');
  }
  void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$id');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Manage Group'),
        centerTitle: true,
      ),
      body:Column(children: [
        ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text('Add Admins'),
          onTap: () => navigateToAddMods(context),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit Community'),
          onTap: () => navigateToModTools(context),
        )
      ]),
    );
  }
}