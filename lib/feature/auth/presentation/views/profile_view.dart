import 'package:flutter/material.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderSection(title: "Profile Settings"),
        elevation: 0,
      ),
      body: ProfileViewBody(),
    );
  }
}
