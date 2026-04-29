import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class Messages extends StatelessWidget {
  const Messages({super.key, required this.isUser, required this.text});

  final bool isUser;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
          padding: EdgeInsets.all(12.sp),
          constraints: BoxConstraints(maxWidth: 280.w),
          decoration: BoxDecoration(
            color: isUser ? AppColor.primaryColor : AppColor.secondaryColor,
            borderRadius: isUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                    bottomLeft: Radius.circular(20.sp),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isUser ? AppColor.darkText : AppColor.lightText,
            ),
          ),
        ),
      ],
    );
  }
}
