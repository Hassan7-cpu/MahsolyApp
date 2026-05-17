import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';

class CustomButtonAuth extends StatefulWidget {
  const CustomButtonAuth({
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
  State<CustomButtonAuth> createState() => _CustomButtonAuthState();
}

class _CustomButtonAuthState extends State<CustomButtonAuth> {
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.isLoading ? null : widget.onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          alignment: Alignment.center,
          width: widget.width ?? double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: widget.isLoading
              ? Text(
                  "Loading${"." * dotCount}",
                  style: AppTextStyle.giloryRegular16(context),
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
