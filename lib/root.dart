import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/feature/auth/presentation/views/setting_view.dart';
import 'package:save_plant/feature/camera/presentation/views/photo_tips_view.dart';
import 'package:save_plant/feature/chat/presentation/view/chatbot_view.dart';
import 'package:save_plant/feature/home/presentation/views/home_view.dart';
import 'package:save_plant/feature/soil_input/presentation/view/soil_input_view.dart';

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

    pages = [HomeView(), PhotoTipsView(), SoilInputView(), ChatbotView()];
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
          pageController.jumpToPage(index);
        },
        items: [
          GlazeNavBarItem(child: Icon(CupertinoIcons.home), label: 'Home'),
          GlazeNavBarItem(
            child: Icon(CupertinoIcons.photo_camera),
            label: 'Camera',
          ),
          GlazeNavBarItem(
            child: Icon(CupertinoIcons.leaf_arrow_circlepath),
            label: 'Soil',
          ),

          GlazeNavBarItem(child: Icon(Icons.smart_toy), label: 'ChatBot'),
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
