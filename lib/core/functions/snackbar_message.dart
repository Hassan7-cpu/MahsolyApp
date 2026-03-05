import 'package:flutter/material.dart';

void snackBarMessage(String s, {required context, required text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
