import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static BoxDecoration card(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
      ],
    );
  }
}
