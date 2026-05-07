import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';

void snackBarMessage(BuildContext context, String text, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: AppTextStyle.giloryRegular14(context)),
      backgroundColor: color,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
  );
}
