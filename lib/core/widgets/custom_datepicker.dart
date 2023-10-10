

import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String labelText;
  final String hintext;
  final Icon icon;
  final TextEditingController? controller;
  final VoidCallback? onCalendarIconTap; // Callback for calendar icon tap

  const CustomDateField({
    required this.labelText,
    required this.hintext,
    this.controller,
    this.onCalendarIconTap, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          labelText,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true, // Make it read-only so that users can't manually edit the date
                controller: controller,
                cursorColor: Colors.blue[300],
                cursorWidth: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: hintext,
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
              ),
            ),
            IconButton(
              icon:icon,
              onPressed: onCalendarIconTap, // Callback to open date picker
            ),
          ],
        ),
      ],
    );
  }
}
