import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';

class BuildSection extends StatelessWidget {
  const BuildSection({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.card(context),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle.giloryRegular16(context)),
            SizedBox(height: 12.h),
            ...children,
          ],
        ),
      ),
    );
  }
}
