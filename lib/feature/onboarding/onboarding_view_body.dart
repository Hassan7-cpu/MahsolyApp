import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_assets.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/onboarding/presentation/views/widgets/onboarding_content.dart';
import 'package:save_plant/feature/onboarding/presentation/views/widgets/onboarding_indicator.dart';

class OnboardingViewbody extends StatefulWidget {
  const OnboardingViewbody({super.key});

  @override
  State<OnboardingViewbody> createState() => _OnboardingViewbodyState();
}

class _OnboardingViewbodyState extends State<OnboardingViewbody> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<Map<String, dynamic>> pages = [
    {
      "image": AppAssets.intro1,
      "title": "Scan Your Plants",
      "desc":
          "Simply take a photo of your plant's leaves or stems.Our advanced camera technology captures every\ndetail needed for accurate diagnosis.",
    },
    {
      "image": AppAssets.intro2,
      "title": "AI-Powered Analysis",
      "desc":
          "Our cutting-edge artificial intelligence analyzes your plant instantly, identifying diseases with high accuracy and providing detailed insights.",
    },
    {
      "image": AppAssets.intro3,
      "title": "Track & Protect",
      "desc":
          "Get personalized treatment recommendations, track your plant's health over time, and join a community of plant enthusiasts.",
    },
  ];
  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SigninView()),
                  );
                },
                child: Text(
                  "Skip",
                  style: AppTextStyle.giloryRegular16(context),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingContent(
                  image: pages[index]["image"]!,
                  title: pages[index]["title"]!,
                  desc: pages[index]["desc"]!,
                );
              },
            ),
          ),
          OnboardingIndicator(pages: pages, currentIndex: currentIndex),
          SizedBox(height: 20.h),
          CustomButton(
            width: MediaQuery.of(context).size.width * 0.65,
            buttonText: currentIndex == pages.length - 1
                ? 'Get Started'
                : 'Next',
            onPressed: nextPage,
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
