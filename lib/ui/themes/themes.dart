import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primarySwatch: Colors.red,
    backgroundColor: Colors.grey.shade900,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return (GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey)));
}

TextStyle get headingStyle {
  return (GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black)));
}

TextStyle get buttonLabelStyle {
  return (GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.redAccent : Colors.white)));
}

TextStyle get dateTimeStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey
      )));
}

TextStyle get dayTimeStyle {
  return (GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600,
          color: Get.isDarkMode ? Colors.grey : Colors.grey)));
}

TextStyle get monthTimeStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey
      )));
}

TextStyle get titleTextStyle {
  return (GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.redAccent : Colors.black)));
}
