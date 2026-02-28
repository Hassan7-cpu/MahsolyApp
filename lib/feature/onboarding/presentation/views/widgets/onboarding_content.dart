import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_strings.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });
  final String image, title, desc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(25),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(image: AssetImage(image)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(title, style: AppString.gilorybold24),
          const SizedBox(height: 15),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: AppString.giloryRegular16.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
