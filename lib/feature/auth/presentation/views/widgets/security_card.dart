import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/change_password_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: AppDecoration.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_clock_outlined, color: AppColor.primaryColor),
              SizedBox(width: 12.w),
              Text("Security", style: AppTextStyle.giloryBold18(context)),
            ],
          ),
          SizedBox(height: 12.h),
          CustomButtonAuth(
            buttonText: "Update Password",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
