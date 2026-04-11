import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/build_icon_text_row.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
    required this.titlegood,
    required this.titlebad,
  });

  final String title, subtitle, titlegood, titlebad;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: AppDecoration.card(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: color, size: 28.sp),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.giloryBold22(context)),

                  Text(subtitle, style: AppTextStyle.giloryRegular18(context)),

                  SizedBox(height: 6.h),

                  BuildIconTextRow(iconColor: Colors.green, text: titlegood),
                  SizedBox(height: 4.h),
                  BuildIconTextRow(iconColor: Colors.red, text: titlebad),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
