import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
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
        height: 60,
        decoration: BoxDecoration(
            color:  AppColor.secondryColor,
          
          borderRadius: BorderRadius.circular(12),
        ),

        child: Text(
          buttonText,
          style: AppTextStyle.giloryRegular18(context)
        ),
      ),
    );
  }
}
