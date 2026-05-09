import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_state.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) async {
        if (state is ChangePasswordSuccess) {
          await CacheHelper().clearData();
          snackBarMessage(
            context,
            "Password changed successfully",
            color: AppColor.primaryColor,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
            (route) => false,
          );
        }

        if (state is ChangePasswordFailure) {
          snackBarMessage(context, state.errMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Change Password',
              style: AppTextStyle.giloryBold24(context),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30.h),

                  CustomTextformfield(
                    hintText: "Current Password",
                    controller: currentPasswordController,
                    prefixIcon: Icons.lock,
                    suffixIcon: Icons.visibility,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validators.loginPasswordValidator,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextformfield(
                    hintText: "New Password",
                    controller: newPasswordController,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: Icons.visibility,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validators.passwordValidator,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextformfield(
                    hintText: "Confirm Password",
                    controller: confirmPasswordController,
                    prefixIcon: Icons.lock_reset,
                    suffixIcon: Icons.visibility,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validators.passwordValidator,
                  ),

                  SizedBox(height: 35.h),

                  CustomButtonAuth(
                    buttonText: "Update Password",
                    isLoading: state is ChangePasswordLoading,
                    onPressed: state is ChangePasswordLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SettingCubit>().changePassword(
                                oldPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text,
                                confirmNewPassword:
                                    confirmPasswordController.text,
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
