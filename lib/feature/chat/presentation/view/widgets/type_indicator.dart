import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  int dotCount = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 400), (t) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Plant Bot is typing${" • " * dotCount}",
      style: AppTextStyle.giloryRegular16(
        context,
      ).copyWith(color: AppColor.secondaryColor),
    );
  }
}
