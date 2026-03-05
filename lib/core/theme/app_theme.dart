// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.lightBackground,

  colorScheme: const ColorScheme.light(
  primary: AppColor.primaryColor,
  secondary: AppColor.secondryColor,
  background: AppColor.lightBackground,
  onBackground: AppColor.darkBackground,
),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),

    cardColor: AppColor.lightContainer,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.darkBackground,

    colorScheme: const ColorScheme.dark(
  primary: AppColor.primaryColor,
  secondary: AppColor.secondryColor,
  background: AppColor.darkBackground,
  onBackground: AppColor.lightBackground,
),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),

    cardColor: AppColor.darkContainer,
  );
}