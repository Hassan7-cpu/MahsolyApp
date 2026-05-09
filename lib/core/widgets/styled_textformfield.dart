import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class StyledTextformfield extends StatelessWidget {
  const StyledTextformfield({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.keyboardType,
    this.validator,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      elevation: 2,
      borderRadius: BorderRadius.circular(10.r),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        cursorColor: theme.colorScheme.primary,
        style: TextStyle(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: theme.colorScheme.surface,
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.4),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2.w),
          ),
          prefixIcon: Icon(prefixIcon, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
