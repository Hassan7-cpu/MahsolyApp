import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_edit_tablefield.dart';

class PersonalInfoCard extends StatefulWidget {
  PersonalInfoCard({super.key});

  @override
  State<PersonalInfoCard> createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: AppDecoration.card(context),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.person, color: AppColor.primaryColor),
              SizedBox(width: 12.w),
              Text(
                "Personal Information",
                style: AppTextStyle.giloryBold18(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ProfileEditTablefield(Focus: nameFocus, text: 'Full Name'),
          SizedBox(height: 12.h),
          ProfileEditTablefield(Focus: emailFocus, text: 'Email'),
        ],
      ),
    );
  }
}
