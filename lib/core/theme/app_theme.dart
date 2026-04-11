// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,

      surface: AppColor.lightContainer,
      onSurface: AppColor.lightText,

      background: AppColor.lightBackground,
      onBackground: AppColor.lightText,
    ),

    scaffoldBackgroundColor: AppColor.lightBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: AppColor.lightContainer,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,

      surface: AppColor.darkContainer,
      onSurface: AppColor.darkText,

      background: AppColor.darkBackground,
      onBackground: AppColor.darkText,
    ),

    scaffoldBackgroundColor: AppColor.darkBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: AppColor.darkContainer,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
  );
}
