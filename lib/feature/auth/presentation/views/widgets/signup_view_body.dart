import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/validators.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void signUp() {
    if (!formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign Up Successful'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    style: AppTextStyle.gilorybold30(context),
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
                    controller: passwordController,

                    hintText: 'Re-enter your password',
                    obscureText: true,
                    suffixIcon: Icons.visibility,
                    validator: Validators.passwordValidator,
                  ),
                  SizedBox(height: 50.h),
                  CustomButtonAuth(
                    onPressed: signUp,
                    buttonText: 'Create Account',
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
