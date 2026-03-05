import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/app_setting_card.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/security_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileHeaderCard(),
            const SizedBox(height: 16),
            PersonalInfoCard(),
            const SizedBox(height: 16),
            const SecurityCard(),
            const SizedBox(height: 16),
            const AppSettingsCard(),
          ],
        ),
    );
  }
}