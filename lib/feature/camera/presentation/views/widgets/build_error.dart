import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';

class BuildError extends StatelessWidget {
  final ScanModel data;

  const BuildError({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.red),
          ),
          child: Text(
            data.message,
            style: AppTextStyle.giloryRegular16(
              context,
            ).copyWith(color: Colors.red.shade800),
          ),
        ),

        SizedBox(height: 12.h),

        if (data.tips != null && data.tips!.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.orange),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tips",
                  style: AppTextStyle.giloryBold18(
                    context,
                  ).copyWith(color: Colors.orange.shade800),
                ),

                SizedBox(height: 10.h),

                ...data.tips!.map(
                  (tip) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            tip,
                            style: AppTextStyle.giloryRegular14(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
