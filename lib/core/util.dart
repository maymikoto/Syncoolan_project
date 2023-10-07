import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade600,
        
        content: Text(text,
        style:Theme.of(context).textTheme.displaySmall ,),
      ),
    );
}

void showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade600,
        
        content: Text(text,
        style:Theme.of(context).textTheme.displaySmall ,),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
