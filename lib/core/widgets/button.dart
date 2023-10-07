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

  const CustomIconTextButton({
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
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 61, 60, 60), // Background color
          borderRadius: BorderRadius.circular(18.0), // Rounded corners
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 12,),
              Text(
                text,
                style:  const TextStyle(
                  fontSize: 16,
                  fontWeight:FontWeight.w400,
                  color: Colors.white, // Text color
                ),
              ),
            ],
          ),
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