import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
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
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),

          borderRadius: BorderRadius.circular(12.r),
        ),

        child: Text(buttonText, style: AppTextStyle.giloryRegular18(context)),
      ),
    );
  }
}
