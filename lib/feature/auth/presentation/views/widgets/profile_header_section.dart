import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';

class ProfileHeaderCard extends StatefulWidget {
  const ProfileHeaderCard({super.key});

  @override
  State<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<ProfileHeaderCard> {
  Future<void> logout() async {
    await CacheHelper().removeData(key: ApiKey.access_token);
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
          CustomButtonAuth(buttonText: 'Logout', onPressed: logout),
        ],
      ),
    );
  }
}
