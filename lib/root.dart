import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/networking/api_constant.dart';

import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/camera/presentation/views/photo_tips_view.dart';
import 'package:save_plant/feature/chat/presentation/view/chatbot_view.dart';
import 'package:save_plant/feature/home/presentation/views/home_view.dart';
import 'package:save_plant/feature/crop_recommendation/presentation/view/soil_input_view.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/view/fertilizer_recommendation_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController pageController;
  int currentPage = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: currentPage);

    pages = [
      const HomeView(),
      const PhotoTipsView(),
      const SoilInputView(),
      const FertilizerRecommendationView(),
      const ChatBotView(),
    ];

    _checkAuth();
  }

  void _checkAuth() {
    final token = CacheHelper().getData(key: ApiKey.access_token);

    final isLoggedIn = token != null && token.toString().isNotEmpty;

    if (!isLoggedIn) {
      Future.microtask(() {
        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
          (route) => false,
        );
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: pages,
      ),

      bottomNavigationBar: GlazeNavBar(
        backgroundColor: Colors.transparent,
        index: currentPage,

        onTap: (index) {
          setState(() {
            currentPage = index;
          });

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        },

        items: const [
          GlazeNavBarItem(
            child: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),

          GlazeNavBarItem(
            child: Icon(CupertinoIcons.camera_fill),
            label: 'Scan',
          ),

          GlazeNavBarItem(child: Icon(Icons.spa_rounded), label: 'Soil'),

          GlazeNavBarItem(
            child: Icon(Icons.grass_rounded),
            label: 'Fertilizer',
          ),

          GlazeNavBarItem(
            child: Icon(Icons.smart_toy_rounded),
            label: 'AI Chat',
          ),
        ],

        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColor.primaryColor, AppColor.secondaryColor],
        ),

        buttonGradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColor.primaryColor, AppColor.secondaryColor],
        ),
      ),
    );
  }
}
