
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
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
          onTap: () {},
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