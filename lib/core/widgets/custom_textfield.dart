import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.controller,
    this.labeltext,
    this.focusNode,
    this.enabled = true,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final String? labeltext;
  final String? hintText;
  final bool enabled;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10.r),
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14.sp,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2.w),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
