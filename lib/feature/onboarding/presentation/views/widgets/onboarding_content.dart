import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.2,
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
          ),

          SizedBox(height: 20.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.giloryBold24(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 10.h),

          Text(
            desc,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.giloryRegular16(
              context,
            ).copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
