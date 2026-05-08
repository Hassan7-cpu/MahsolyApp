import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/setting_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_header_section.dart';
import 'package:save_plant/feature/home/presentation/views/dashboard_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 20.h),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              size: 28.sp,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            title: Text(
              "Dashboard",
              style: AppTextStyle.giloryRegular18(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardView()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 28.sp,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            title: Text(
              "Settings",
              style: AppTextStyle.giloryRegular18(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
