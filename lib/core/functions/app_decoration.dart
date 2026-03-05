import 'package:flutter/material.dart';

class AppDecoration {

  static BoxDecoration card(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
        ),
      ],
    );
  }

}