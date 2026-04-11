// ignore_for_file: must_be_immutable, deprecated_member_use, unused_label, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_assets.dart';

import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/login_view_body.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/text_description.dart';

class SigninView extends StatefulWidget {
  SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: HeaderSection(image: AppAssets.logo, title: "PlantCare AI"),
        ),
        body: LoginViewBody(),
      ),
    );
  }
}
