import 'package:flutter/material.dart';
import 'package:save_plant/core/theme/text_style.dart';

class TilteDescription extends StatelessWidget {
  TilteDescription({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTextStyle.roboto16(context)),
    );
  }
}
