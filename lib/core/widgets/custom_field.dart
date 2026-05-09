import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/widgets/styled_textformfield.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.keyboardType,
    required this.validator,
  });

  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: StyledTextformfield(
        hintText: hint,
        prefixIcon: icon,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
