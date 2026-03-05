import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {

  static TextStyle roboto16(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle roboto18(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle giloryRegular16(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Gilory',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }
   static TextStyle giloryRegular18(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: 'Gilory',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle giloryBold18(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilory',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle giloryBold24(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilory',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle? gilorybold30(BuildContext context) {
    return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilory',
      color: Theme.of(context).colorScheme.onBackground,
    );
  }
}