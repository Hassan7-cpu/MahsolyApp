import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String buttonText;
  final double? width;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  int dotCount = 1;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (widget.isLoading) {
        setState(() {
          dotCount = dotCount % 3 + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressed,
      child: Container(
        width: widget.width ?? double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.secondaryColor],
          ),
        ),
        child: Center(
          child: widget.isLoading
              ? Text(
                  "Loading${"." * dotCount}",
                  style: AppTextStyle.giloryRegular18(context),
                )
              : Text(
                  widget.buttonText,
                  style: AppTextStyle.giloryRegular18(context),
                ),
        ),
      ),
    );
  }
}
