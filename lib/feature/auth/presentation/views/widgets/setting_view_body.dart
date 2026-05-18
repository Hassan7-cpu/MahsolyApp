import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/app_setting_card.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_header_section.dart';

class SettingViewBody extends StatefulWidget {
  const SettingViewBody({super.key});

  @override
  State<SettingViewBody> createState() => _SettingViewBodyState();
}

class _SettingViewBodyState extends State<SettingViewBody> {
  Future<void> logout() async {
    await CacheHelper().removeData(key: ApiKey.access_token);
    await CacheHelper().removeData(key: ApiKey.refresh_token);
    await CacheHelper().removeData(key: ApiKey.id);
    await CacheHelper().removeData(key: ApiKey.email);
    await CacheHelper().removeData(key: ApiKey.name);

    if (!mounted) return;

    final themeCubit = ThemeCubit.get(context);
    themeCubit.reset();

    context.read<UserCubit>().logout();

    snackBarMessage(context, "Logged out successfully", color: Colors.green);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.r),
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            ProfileHeaderCard(),
            SizedBox(height: 16.h),
            AppSettingsCard(),
            SizedBox(height: 20.h),
            CustomButtonAuth(buttonText: 'Logout', onPressed: logout),
          ],
        ),
      ),
    );
  }
}
