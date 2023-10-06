import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;

  CustomSearchBar({required this.onChanged, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onClose,
      ),
      title: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onChanged('');
          },
        ),
      ],
    );
  }
}
