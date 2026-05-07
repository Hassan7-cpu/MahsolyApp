import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/app_setting_card.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/security_card.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_header_section.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.r),
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            ProfileHeaderCard(name: CacheHelper().getData(key: 'name') ?? ""),
            SizedBox(height: 16.h),
            SecurityCard(),
            SizedBox(height: 16.h),
            AppSettingsCard(),
          ],
        ),
      ),
    );
  }
}
