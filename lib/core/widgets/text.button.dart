import 'package:flutter/material.dart';
import 'package:syncoplan_project/theme/theme.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onTap;

  const CustomTextButton({
    Key? key, // Use Key key here
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child:const Text('Edit',
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.lightBlue,
      ),
      ),
   
    );
  }
}
