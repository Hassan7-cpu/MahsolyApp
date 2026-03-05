import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/profile_view.dart';
import 'package:save_plant/feature/auth/presentation/views/signup_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
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
    Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProfileView()),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 20),
                Text('Welcome Back', style: AppTextStyle.gilorybold30(context)),
                Text(
                  'Sign in to continue protecting your plants',
                  style: AppTextStyle.giloryRegular16(context),
                ),
                SizedBox(height: 50),

                TilteDescription(title: 'Email'),
                SizedBox(height: 3),
                CustomTextformfield(
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,

                  hintText: 'Enter your email',
                ),
                SizedBox(height: 15),
                TilteDescription(title: 'Password'),
                SizedBox(height: 3),
                CustomTextformfield(
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,

                  hintText: 'Enter your password',
                  suffixIcon: CupertinoIcons.eye,
                  obscureText: true,
                ),
    
                SizedBox(height: 50),
                CustomButtonAuth(
                  onPressed: login,
                  buttonText: 'Login',
                ),
                SizedBox(height: 15),
                CustomButtonAuth(
                  onPressed:(){
                    Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SignupView()));
                  } ,
                  buttonText: 'Create an account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
