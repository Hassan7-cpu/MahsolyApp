import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key, required this.controller, required this.labeltext});
  final TextEditingController? controller;
  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return  TextField(
            controller: controller,
            cursorColor: AppColor.secondaryColor,
            style: TextStyle(color: AppColor.secondaryColor),
            decoration: InputDecoration(
              label: Text(labeltext),
              labelStyle: TextStyle(color: AppColor.secondaryColor),
            //  prefixIcon: Icon(CupertinoIcons.person,color: AppColor.secondaryColor,),
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColor.secondaryColor)
            ),
            focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColor.secondaryColor)
            ), 
            ),
          
          );
  }
}