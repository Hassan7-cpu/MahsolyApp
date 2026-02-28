import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/constants/app_strings.dart';
import 'package:save_plant/core/utils/validators.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
    context.push('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HeaderSection(title: "PlantCare AI"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Account', style: AppString.gilorybold30),
                    Text(
                      'Start protecting your plants today',
                      style: AppString.giloryRegular16,
                    ),
                     SizedBox(height: 50),
                    TilteDescription(title: 'Full Name'),
                    SizedBox(height: 3),
                    CustomTextformfield(
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      hintText: 'Enter your name',
                      validator: Validators.nameValidator,
                    ),
                    SizedBox(height: 20),
                    TilteDescription(title: 'Phone'),
                    SizedBox(height: 3),
                    CustomTextformfield(
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,

                      hintText: "Enter your phone number",
                      controller: phoneController,
                      validator: Validators.phoneValidator,
                    ),
                    SizedBox(height: 20),
                    TilteDescription(title: 'Email'),
                    SizedBox(height: 3),
                    CustomTextformfield(
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'Enter your email',
                      validator: Validators.emailValidator,
                    ),

                    SizedBox(height: 20),
                    TilteDescription(title: 'Password'),
                    SizedBox(height: 3),
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
                    SizedBox(height: 50),
                    CustomButtonAuth(
                      isLoading: false,
                      onPressed: signUp,
                      buttonText: 'Create Account',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
