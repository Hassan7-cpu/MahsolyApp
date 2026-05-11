import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';

class PlantBuildSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;

  const PlantBuildSection({
    super.key,
    required this.title,
    required this.items,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.giloryBold18(context).copyWith(color: color),
          ),
          SizedBox(height: 10.h),
          ...items.map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6.sp, color: color),
                  SizedBox(width: 8.w),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
