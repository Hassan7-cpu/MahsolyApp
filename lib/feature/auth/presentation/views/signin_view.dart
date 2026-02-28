// ignore_for_file: must_be_immutable, deprecated_member_use, unused_label, unused_import, unused_local_variable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/constants/app_strings.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class SigninView extends StatefulWidget {
  SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
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
    context.go('/root');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
        title:  HeaderSection(title: "PlantCare AI",),
        ),
        body: GestureDetector(
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
                    SizedBox(height: 40),
                    Text('Welcome Back',style:AppString.gilorybold30 ,),
                    Text('Sign in to continue protecting your plants',style: AppString.giloryRegular16,),
                    SizedBox(height: 50),
                   
                              TilteDescription(title: 'Email'),
                              SizedBox(height: 3),
                              CustomTextformfield(
                                prefixIcon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                
                                hintText: 'Enter your email',
                              ),
                              SizedBox(height: 20),
                              TilteDescription(title: 'Password'),
                              SizedBox(height: 3),
                              CustomTextformfield(
                                prefixIcon:Icons.lock,
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                
                                hintText: 'Enter your password',
                                suffixIcon: CupertinoIcons.eye,
                                obscureText: true,
                              ),
                              SizedBox(height: 50),
                              CustomButtonAuth(
                                isLoading:isLoading,
                                backgroundColor: Colors.transparent,
                                color: AppColor.secondaryColor,
                                onPressed: login, buttonText: 'Login'),
                              SizedBox(height: 15),
                              CustomButtonAuth(
                                isLoading:false,
                                onPressed: () {
                                   context.push('/signup');
                                },
                                buttonText: 'Create an account',
                              ),
                            ],
                          ),
              ),
            ),
        
        
            ),
        ),
      ),
    );
  }
}
