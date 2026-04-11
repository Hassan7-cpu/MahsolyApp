import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  final String title, desc;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            flex: 6,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(25.r),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          SizedBox(height: 30.h),
          Flexible(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.giloryBold24(context),
            ),
          ),

          SizedBox(height: 10.h),

          Flexible(
            flex: 2,
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: AppTextStyle.giloryRegular16(
                context,
              ).copyWith(color: Colors.grey),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
