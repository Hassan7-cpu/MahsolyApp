import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';

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
          Expanded(
            flex: 6,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(25),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          Flexible(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.giloryBold24(context),
            ),
          ),

          const SizedBox(height: 10),

          Flexible(
            flex: 2,
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: AppTextStyle.giloryRegular16(context).copyWith(color: Colors.grey),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
