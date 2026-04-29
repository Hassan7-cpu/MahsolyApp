import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/user_state.dart';
import 'package:save_plant/feature/auth/presentation/views/otp_view.dart';
import 'package:save_plant/feature/auth/presentation/views/signup_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';
import 'package:save_plant/root.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void login() {
    if (formKey.currentState!.validate()) {
      context.read<UserCubit>().signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            snackBarMessage(context, state.errMessage, color: Colors.red);
          }
          if (state is SignInNeedVerification) {
            snackBarMessage(context, state.message, color: Colors.orange);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => OtpView(email: state.email)),
            );
          }
          if (state is SignInSuccess) {
            snackBarMessage(context, "Login successful", color: Colors.green);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Root()),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Welcome Back',
                      style: AppTextStyle.giloryBold30(context),
                    ),
                    Text(
                      'Sign in to continue protecting your plants',
                      style: AppTextStyle.giloryRegular16(context),
                    ),
                    SizedBox(height: 50.h),

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
                      validator: Validators.loginPasswordValidator,
                      hintText: 'Enter your password',
                      suffixIcon: CupertinoIcons.eye,
                      obscureText: true,
                    ),

                    SizedBox(height: 50.h),
                    CustomButtonAuth(
                      onPressed: login,
                      buttonText: '',
                      child: state is SignInLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                            )
                          : Text(
                              'Login',
                              style: AppTextStyle.giloryRegular18(context),
                            ),
                    ),
                    SizedBox(height: 15.h),
                    CustomButtonAuth(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignupView()),
                        );
                      },
                      buttonText: 'Create a new account',
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
