import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:save_plant/root.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<Offset> textAnimation;
  late Animation<Offset> imageAnimation;

  String displayedText = "";
  final String fullText = "Mahsoly";

  Timer? timer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    textAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    imageAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();

    typeWriterEffect();

    navigate();
  }

  void typeWriterEffect() {
    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (displayedText.length < fullText.length) {
        setState(() {
          displayedText = fullText.substring(0, displayedText.length + 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final token = CacheHelper().getData(key: ApiKey.access_token);

    final seen = CacheHelper().getData(key: "onboardingSeen") ?? false;

    final isLoggedIn =
        token != null &&
        token.toString().isNotEmpty &&
        !JwtDecoder.isExpired(token);

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
      );
      return;
    }

    if (!seen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingView()),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: textAnimation,
              child: Text(
                displayedText,
                style: AppTextStyle.giloryBold30(
                  context,
                ).copyWith(color: AppColor.primaryColor),
              ),
            ),

            SizedBox(height: 20.h),

            SlideTransition(
              position: imageAnimation,
              child: Image.asset(
                "assets/images/logo/into.png",
                width: 160.w,
                height: 160.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
