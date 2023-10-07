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




class CustomIconTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  CustomIconTextButton({
    super.key, 
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 61, 60, 60), // Background color
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.yellow.shade600,
            ),
            const SizedBox(width: 12.0), // Add spacing between icon and text
            Text(
              text,
              style:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.yellow.shade600, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*
class CustomIconTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconTextButton({
    super.key, 
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.yellow.shade800
      ),
      ),
    );
  }
}
*/