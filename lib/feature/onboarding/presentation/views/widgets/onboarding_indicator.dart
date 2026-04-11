import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.pages,
    required this.currentIndex,
  });
  final List<Map<String, dynamic>> pages;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: currentIndex == index ? 25 : 7,
          height: 6.h,
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColor.primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
