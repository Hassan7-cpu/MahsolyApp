import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key,required this.pages, required this.currentIndex});
final List <Map<String, String>> pages;
final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 22 : 7,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColor.primaryColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ) ;
  }
}