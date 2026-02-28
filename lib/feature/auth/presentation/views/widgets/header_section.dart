import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/constants/app_strings.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
       mainAxisAlignment :MainAxisAlignment.center,
      children: [
       
        Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fill,
        ),
        SizedBox(width: 30),
        Text(
          title,
          style: 
          AppString.gilorybold24.copyWith(
            color: AppColor.primaryColor,
          ),
          ),
      ],
    );
  }
}
