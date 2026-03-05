import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labeltext,
    this.focusNode,
    this.enabled = true,
  });
  final TextEditingController? controller;
  final String labeltext;
  final bool enabled;
  final FocusNode? focusNode;

  @override
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        style: const TextStyle(color: AppColor.darkBackground),
        decoration: InputDecoration(
          labelText: labeltext,
          filled: true,
          fillColor: enabled
              ? AppColor.lightBackground
              : Colors.grey.shade200, // لون مختلف لما يكون مقفول
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }
}
