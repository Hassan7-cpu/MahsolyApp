import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_state.dart';
import 'package:save_plant/feature/auth/presentation/views/otp_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            snackBarMessage(context, state.errMessage, color: Colors.red);
          });
        }

        if (state is SignUpSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            snackBarMessage(
              context,
              state.message,
              color: AppColor.primaryColor,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpView(email: emailController.text),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      Text(
                        'Create Account',
                        style: AppTextStyle.giloryBold30(context),
                      ),
                      Text(
                        'Start protecting your plants today',
                        style: AppTextStyle.giloryRegular16(context),
                      ),
                      SizedBox(height: 50.h),
                      TilteDescription(title: 'Full Name'),
                      SizedBox(height: 3.h),
                      CustomTextformfield(
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        hintText: 'Enter your name',
                        validator: Validators.nameValidator,
                      ),
                      SizedBox(height: 15.h),
                      TilteDescription(title: 'Email'),
                      SizedBox(height: 3.h),
                      CustomTextformfield(
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: 'Enter your email',
                        validator: Validators.emailValidator,
                      ),
                      SizedBox(height: 15.h),
                      TilteDescription(title: 'Password'),
                      SizedBox(height: 3.h),
                      CustomTextformfield(
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,

                        hintText:
                            'At least 8 characters, a capital letter and a number',
                        obscureText: true,
                        suffixIcon: Icons.visibility,
                        validator: Validators.passwordValidator,
                      ),
                      SizedBox(height: 15.h),
                      TilteDescription(title: 'Confirm Password'),
                      SizedBox(height: 3.h),
                      CustomTextformfield(
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,

                        hintText: 'Re-enter your password',
                        obscureText: true,
                        suffixIcon: Icons.visibility,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50.h),
                      CustomButtonAuth(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<UserCubit>().signUp(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          print("SIGNUP STARTED");
                        },
                        buttonText: '',
                        child: state is SignUpLoading
                            ? CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                            : Text('Create Account'),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
