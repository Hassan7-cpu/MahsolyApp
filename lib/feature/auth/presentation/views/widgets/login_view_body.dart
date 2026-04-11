import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';
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
  bool isLoading = false;
  void login() {
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Root()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text('Welcome Back', style: AppTextStyle.gilorybold30(context)),
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
                ),
                SizedBox(height: 15.h),
                TilteDescription(title: 'Password'),
                SizedBox(height: 3.h),
                CustomTextformfield(
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,

                  hintText: 'Enter your password',
                  suffixIcon: CupertinoIcons.eye,
                  obscureText: true,
                ),

                SizedBox(height: 50.h),
                CustomButtonAuth(onPressed: login, buttonText: 'Login'),
                SizedBox(height: 15.h),
                CustomButtonAuth(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupView()),
                    );
                  },
                  buttonText: 'Create a new account',
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
