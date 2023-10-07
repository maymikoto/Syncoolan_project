// ignore_for_file: depend_on_referenced_packages, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptheme {
  // ----------- App Colors --------------
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color focusColor = Color(0xFF010101);
  static const Color nofocusColor = Color(0xFFD8DADC);
  static const Color fieldBoarderColor = Color(0xFFD8DADC);
  static const Color textLargeColor = Color(0xFF010101);
  static const Color textMediumColor = Color(0xFFD8D9DA);
  static const Color textsmallColor = Color(0xFF010101);
  static const Color errorColor = Color(0xFFE74646);
  static const Color confirmColor = Color(0xFFE5D9C59);

//-------------- App Text style --------------------
  static ThemeData defaultTheme() {
    return ThemeData(
        scaffoldBackgroundColor: Apptheme.backgroundColor,
        fontFamily: GoogleFonts.notoSansThai().fontFamily,
        hintColor: Colors.black45,
        appBarTheme: const AppBarTheme(

          backgroundColor: Colors.black87,
          titleTextStyle: TextStyle(fontSize: 18)),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),          
          displayLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white), //button style
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          displaySmall: TextStyle(      //For SnackBar
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),     
        ) //Button Text Style
        );
  }
}

// -----------  Other TextStyle --------------------

TextStyle textButtonStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w900,
  color: Colors.blue.shade500,
);