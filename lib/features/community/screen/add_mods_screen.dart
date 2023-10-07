import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/widgets/error_text.dart';
import 'package:syncoplan_project/core/widgets/loader.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';
import 'package:syncoplan_project/features/community/controllers/commu_controller.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  final String id;
  const AddModsScreen({
    Key? key,
    required this.id,
  });

  @override
  _AddModsScreenState createState() => _AddModsScreenState();
}

class _AddModsScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};

  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void toggleUid(String uid) {
    setState(() {
      if (uids.contains(uid)) {
        uids.remove(uid);
      } else {
        uids.add(uid);
      }
    });
  }

  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.id,
          uids.toList(),
          context,
        );
  }

  @override
  void initState() {
    super.initState();
    // Load the initial mods into uids when the screen initializes
    ref
        .read(getCommunityByIdProvider(widget.id))
        .when(data: (community) {
      setState(() {
        uids.addAll(community.mods); // Add all mods to the selected mods set
      });
    },
        error: (error, stackTrace) => ErrorText(error: error.toString(),),
        loading: () => const Loader(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByIdProvider(widget.id)).when(
        data: (community) => ListView.builder(
          itemCount: community.members.length,
          itemBuilder: (BuildContext context, int index) {
            final member = community.members[index];

            return ref.watch(getUserDataProvider(member)).when(
              data: (user) {
                return CheckboxListTile(
                  value: uids.contains(user.uid),
                  onChanged: (val) {
                    toggleUid(user.uid); // Toggle the selection
                  },
                  title: Text(user.name),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
          },
        ),
        error: (error, stackTrace) => ErrorText(
          error: error.toString(),
        ),
        loading: () => const Loader(),
      ),
    );
  }
}
