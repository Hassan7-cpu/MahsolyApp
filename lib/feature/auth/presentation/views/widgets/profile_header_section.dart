import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/security_card.dart';

class ProfileHeaderCard extends StatefulWidget {
  const ProfileHeaderCard({super.key});

  @override
  State<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<ProfileHeaderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: AppDecoration.card(context),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(CupertinoIcons.person, color: AppColor.primaryColor),
              SizedBox(width: 12.w),
              Text(
                "Personal Information",
                style: AppTextStyle.giloryBold18(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          PersonalInfoCard(),
          SizedBox(height: 20.h),
          SecurityCard(),
        ],
      ),
    );
  }
}
