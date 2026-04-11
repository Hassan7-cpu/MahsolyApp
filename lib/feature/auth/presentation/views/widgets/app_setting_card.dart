import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
import 'package:save_plant/core/theme/cubit/theme_state.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/app_decoration.dart';

class AppSettingsCard extends StatefulWidget {
  const AppSettingsCard({super.key});

  @override
  State<AppSettingsCard> createState() => _AppSettingsCardState();
}

class _AppSettingsCardState extends State<AppSettingsCard> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: AppDecoration.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("App Settings", style: AppTextStyle.giloryBold18(context)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDark
                  ? Text(
                      "Dark Mode",
                      style: AppTextStyle.giloryRegular16(context),
                    )
                  : Text(
                      "Light Mode",
                      style: AppTextStyle.giloryRegular16(context),
                    ),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Switch(
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      ThemeCubit.get(
                        context,
                      ).setTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
