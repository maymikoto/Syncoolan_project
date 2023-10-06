import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final Function()? onTap;
  final String labeltext;

  const LongButton({
    Key? key,
    required this.onTap,
    required this.labeltext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            labeltext, 
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
