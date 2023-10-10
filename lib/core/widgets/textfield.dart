import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintext;
  final TextEditingController? controller;
  final Widget? widget;

  const CustomTextField({
    required this.labelText,
    required this.hintext,
    this.widget,
    this.controller,
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
        TextField(
          readOnly: widget == null ? false : true,
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
      ],
    );
  }
}
