import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';

class CustomTextformfield extends StatefulWidget {
  const CustomTextformfield({
    super.key,
    required this.hintText,
    this.suffixIcon,
   required this.prefixIcon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    required this.keyboardType, 
  });

  final String hintText;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator; 
  final TextInputType keyboardType;

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        keyboardType:widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor:AppColor.secondaryColor,
          hintStyle: const TextStyle(color:AppColor.blackColor),
          enabledBorder: OutlineInputBorder(
          
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
