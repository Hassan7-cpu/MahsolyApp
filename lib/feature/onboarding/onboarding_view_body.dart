import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_plant/core/constants/app_strings.dart';
import 'package:save_plant/core/helper/custom_button.dart';
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

  List<Map<String, String>> pages = [
    {
      "image": "assets/images/logo1.png",
      "title": "Scan Your Plants",
      "desc":
          "Simply take a photo of your plant's leaves or stems.\nOur advanced camera technology captures every\ndetail needed for accurate diagnosis."
    },
    {
      "image": "assets/images/logo2.png",
      "title": "AI-Powered Analysis",
      "desc":
          "Our cutting-edge artificial intelligence analyzes your\nplant instantly, identifying diseases with high\naccuracy and providing detailed insights."
    },
    {
      "image": "assets/images/logo3.png",
      "title": "Track & Protect",
      "desc":
          "Get personalized treatment recommendations, track\nyour plant's health over time, and join a community\nof plant enthusiasts."
    },
  ];
  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      (context).push('/signin');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
                  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 ),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){(context).push('/signin');},
                child: Text(
                  "Skip",
                  style: AppString.giloryRegular18,
                ),
              ),
            ),
          ),
              SizedBox(height: 50,),
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
               const SizedBox(height: 20),
               CustomButton(
                width: MediaQuery.of(context).size.width * 0.65,
                buttonText:currentIndex==pages.length-1 ? 'Get Started':'Next',
                onPressed:nextPage,
               ),
               SizedBox(height: 50,),
          ],
      ),
    );
  }
}
