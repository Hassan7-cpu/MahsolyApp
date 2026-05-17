import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      title,
      style: AppTextStyle.giloryBold22(context),
    );
  }
}
