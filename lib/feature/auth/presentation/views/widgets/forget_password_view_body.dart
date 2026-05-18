import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_state.dart';
import 'package:save_plant/feature/auth/presentation/views/forgot_password_otp_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _submitEmail() {
    if (formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().forgotPassword(
        email: emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordFailure) {
            snackBarMessage(context, state.errMessage, color: Colors.red);
          }
          if (state is ForgotPasswordSuccess) {
            snackBarMessage(
              context,
              state.response.message,
              color: Colors.green,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ForgotPasswordOtpView(email: emailController.text.trim()),
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
                    SizedBox(height: 20.h),
                    Text(
                      'Forgot Password',
                      style: AppTextStyle.giloryBold30(context),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Please enter your email to receive verification code',
                      style: AppTextStyle.giloryRegular16(context),
                    ),
                    SizedBox(height: 50.h),
                    TilteDescription(title: 'Email Address'),
                    SizedBox(height: 5.h),
                    CustomTextformfield(
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'Enter your email',
                      validator: Validators.emailValidator,
                    ),
                    SizedBox(height: 40.h),
                    CustomButtonAuth(
                      onPressed: _submitEmail,
                      buttonText: 'Send Code',
                      isLoading: state is ForgotPasswordLoading,
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
