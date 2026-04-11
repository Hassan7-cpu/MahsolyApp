import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.width,
  });

  final VoidCallback? onPressed;
  final String buttonText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.secondaryColor],
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColor.lightBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
