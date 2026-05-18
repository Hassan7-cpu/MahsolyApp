import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_state.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class ResetPasswordViewBody extends StatefulWidget {
  final String email;

  const ResetPasswordViewBody({super.key, required this.email});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().resetPassword(
        email: widget.email,
        newPassword: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailure) {
            snackBarMessage(context, state.errMessage, color: Colors.red);
          }
          if (state is ResetPasswordSuccess) {
            snackBarMessage(
              context,
              state.response.message.isNotEmpty
                  ? state.response.message
                  : "Password reset successful",
              color: Colors.green,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginView()),
              (route) => false,
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
                      'Reset Password',
                      style: AppTextStyle.giloryBold30(context),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Enter your new password and verify it below.',
                      style: AppTextStyle.giloryRegular16(context),
                    ),
                    SizedBox(height: 40.h),
                    TilteDescription(title: 'New Password'),
                    SizedBox(height: 5.h),
                    CustomTextformfield(
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      hintText: 'Enter new password',
                      suffixIcon: CupertinoIcons.eye,
                      obscureText: true,
                      validator: Validators.passwordValidator,
                    ),
                    SizedBox(height: 20.h),
                    TilteDescription(title: 'Confirm Password'),
                    SizedBox(height: 5.h),
                    CustomTextformfield(
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      hintText: 'Confirm new password',
                      suffixIcon: CupertinoIcons.eye,
                      obscureText: true,
                      validator: (value) => Validators.confirmPasswordValidator(
                        value,
                        passwordController.text,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomButtonAuth(
                      onPressed: resetPassword,
                      buttonText: 'Reset Password',
                      isLoading: state is ResetPasswordLoading,
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
