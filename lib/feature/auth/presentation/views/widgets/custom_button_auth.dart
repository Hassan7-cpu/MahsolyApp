import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/constants/app_strings.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.color,
    this.isLoading = false, 
    this.width, 
  });

  final VoidCallback? onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final Color? color;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        alignment:Alignment.center,
                width:width?? double.infinity,
         height: 60,
         decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00C853), Color(0xFF11998E)],
          ),
              borderRadius: BorderRadius.circular(12),
         ),
         
            child: isLoading
                ? const CircularProgressIndicator(color: AppColor.primaryColor) // ✅ Loading indicator
                : Text(
                    buttonText,
                    style: AppString.gilorybold16.copyWith(color:AppColor.secondaryColor,fontSize: 18),
                  ),
          ),
    );
  }
}