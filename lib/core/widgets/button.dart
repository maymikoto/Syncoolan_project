import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncoplan_project/core/constants/constants.dart';
import 'package:syncoplan_project/features/auth/controllers/auth_controller.dart';


//  ------------------   Long Text  Button     ---------------------

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

 
//  ------------------   Text + Icon Button     ---------------------

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

//  ------------------   Google Sign In Button ---------------------

class SignInButton extends ConsumerWidget{
  const SignInButton({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref){
    ref.read(AuthControllerProvider.notifier).signInWithGoogle(context);    
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle(context , ref),
        icon: Image.asset(
          Constants.googlePath,
          width: 35,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}