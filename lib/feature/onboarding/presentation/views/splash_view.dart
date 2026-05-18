import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
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
  late Animation<int> animation;

  final String text = 'Mahsoly';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = IntTween(begin: 0, end: text.length).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigate();
      }
    });

    controller.forward();
  }

  Future<void> navigate() async {
    final refreshToken = CacheHelper().getData(key: ApiKey.refresh_token);
    final seen = CacheHelper().getData(key: "onboardingSeen") ?? false;

    bool isLoggedIn = false;

    if (refreshToken != null && refreshToken.toString().isNotEmpty) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    if (!mounted) return;

    if (isLoggedIn) {
      final email = CacheHelper().getData(key: ApiKey.email);
      if (email != null && email is String) {
        ThemeCubit.get(context).setUser(email);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
      );
      return;
    }

    await CacheHelper().removeData(key: ApiKey.access_token);
    await CacheHelper().removeData(key: ApiKey.refresh_token);
    await CacheHelper().removeData(key: ApiKey.id);

    if (!seen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginView()),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          text.substring(0, animation.value),
          style: GoogleFonts.pacifico(
            fontSize: 48,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
