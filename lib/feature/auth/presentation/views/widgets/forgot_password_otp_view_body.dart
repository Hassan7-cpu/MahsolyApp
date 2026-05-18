import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_state.dart';
import 'package:save_plant/feature/auth/presentation/views/reset_password_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class ForgotPasswordOtpViewBody extends StatefulWidget {
  final String email;

  const ForgotPasswordOtpViewBody({super.key, required this.email});

  @override
  State<ForgotPasswordOtpViewBody> createState() =>
      _ForgotPasswordOtpViewBodyState();
}

class _ForgotPasswordOtpViewBodyState extends State<ForgotPasswordOtpViewBody> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void verifyOtp() {
    if (formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().verifyOtp(
        email: widget.email,
        otp: otpController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is VerifyOtpFailure) {
            snackBarMessage(context, state.errMessage, color: Colors.red);
          }
          if (state is VerifyOtpSuccess) {
            snackBarMessage(
              context,
              state.response.message,
              color: Colors.green,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordView(email: widget.email),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Verify OTP',
                      style: AppTextStyle.giloryBold30(context),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Enter the 6-digit OTP code sent to',
                      style: AppTextStyle.giloryRegular16(context),
                    ),
                    Text(
                      widget.email,
                      style: AppTextStyle.giloryBold18(
                        context,
                      ).copyWith(color: AppColor.primaryColor),
                    ),
                    SizedBox(height: 50.h),
                    TilteDescription(title: 'OTP Code'),
                    SizedBox(height: 5.h),
                    CustomTextformfield(
                      prefixIcon: Icons.domain_verification_outlined,
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      hintText: 'Enter 6-digit code',
                      validator: Validators.otpValidator,
                    ),
                    SizedBox(height: 40.h),
                    CustomButtonAuth(
                      onPressed: verifyOtp,
                      buttonText: 'Verify OTP',
                      isLoading: state is VerifyOtpLoading,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
