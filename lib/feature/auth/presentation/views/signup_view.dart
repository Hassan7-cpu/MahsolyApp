// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: HeaderSection(title: "Mahsoly")),
        body: SignupViewBody(),
      ),
    );
  }
}
