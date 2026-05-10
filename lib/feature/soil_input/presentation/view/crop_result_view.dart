import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/header_section.dart';

class CropResultView extends StatelessWidget {
  final String crop;
  final String explanation;

  const CropResultView({
    super.key,
    required this.crop,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderSection(title: 'Result')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade700],
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 50.sp,
                    color: Theme.of(context).colorScheme.surface,
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    "Recommended Crop",
                    style: AppTextStyle.giloryRegular16(
                      context,
                    ).copyWith(color: Theme.of(context).colorScheme.surface),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    crop.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.giloryBold30(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColor.primaryColor),
                      SizedBox(width: 10.w),
                      Text(
                        "Explanation",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    explanation,
                    style: AppTextStyle.giloryRegular14(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
