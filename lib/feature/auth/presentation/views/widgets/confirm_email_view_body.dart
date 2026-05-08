import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/confirm_email_otp_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/confirm_email_otp_state.dart';
import 'package:save_plant/feature/auth/presentation/views/setting_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';

class ConfirmEmailViewBody extends StatelessWidget {
  ConfirmEmailViewBody({super.key, required this.email});
  final String email;

  final TextEditingController otpController = TextEditingController();
  void verifyOtp(BuildContext context) {
    context.read<EmailOtpCubit>().verifyOtp(
      email: email,
      otp: otpController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: BlocConsumer<EmailOtpCubit, EmailOtpState>(
        listener: (context, state) {
          if (state is EmailOtpSuccess) {
            snackBarMessage(
              context,
              state.message,
              color: AppColor.primaryColor,
            );
            CacheHelper().saveData(key: 'email', value: email);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SettingView()),
              (route) => false,
            );
          }

          if (state is EmailOtpFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter the OTP sent to your email",
                style: AppTextStyle.giloryBold18(context),
              ),
              SizedBox(height: 5.h),
              Text(
                email,
                style: AppTextStyle.giloryRegular16(
                  context,
                ).copyWith(color: AppColor.primaryColor),
              ),

              SizedBox(height: 25.h),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP Code",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: CustomButtonAuth(
                  onPressed: () => verifyOtp(context),
                  buttonText: 'Verify',
                  isLoading: state is EmailOtpLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
