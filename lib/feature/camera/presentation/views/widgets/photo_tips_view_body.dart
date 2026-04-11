import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/camera/presentation/views/camera_view.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/action_card.dart';

class PhotoTipsViewBody extends StatelessWidget {
  const PhotoTipsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionCard(
                title: '1. Choose Good Lighting',
                subtitle: 'Use natural daylight and avoid shadows.',
                iconData: Icons.light_mode,
                color: AppColor.secondaryColor,
                titlegood: 'Natural light or sufficient illumination',
                titlebad: 'Dim lighting or harsh shadows',
              ),

              SizedBox(height: 16.h),

              ActionCard(
                title: '2. Focus on the Issue ',
                subtitle: 'Take a close photo of the affected area.',
                iconData: Icons.center_focus_strong,
                color: AppColor.primaryColor,
                titlegood: 'Close-up, clear photo of affected area',
                titlebad: 'Distant or blurry photo',
              ),

              SizedBox(height: 16.h),

              ActionCard(
                title: '3. Keep Camera Steady',
                subtitle: 'Hold the phone steady to avoid blur.',
                iconData: Icons.camera_alt,
                color: const Color(0xFF9333EA),
                titlegood: 'Sharp, steady image',
                titlebad: 'Shaky or blurry image',
              ),

              SizedBox(height: 16.h),

              ActionCard(
                title: '4. Use Clean Background',
                subtitle: 'Use a simple background to highlight the plant.',
                iconData: Icons.auto_awesome,
                color: const Color(0xFFF59E0B),
                titlegood: 'Simple, neutral background',
                titlebad: 'Cluttered or distracting background',
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraView()),
                  );
                },
                buttonText: "Start Camera",
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
