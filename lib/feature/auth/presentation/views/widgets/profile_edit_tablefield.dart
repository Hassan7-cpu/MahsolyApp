// ignore_for_file: non_constant_identifier_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/custom_textfield.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_cubit.dart';

class ProfileEditTablefield extends StatefulWidget {
  const ProfileEditTablefield({
    super.key,
    required this.focus,
    required this.text,
    required this.controller,
    this.isEmail = false,
  });

  final FocusNode focus;
  final String text;
  final TextEditingController controller;
  final bool isEmail;

  @override
  State<ProfileEditTablefield> createState() => _ProfileEditTablefieldState();
}

class _ProfileEditTablefieldState extends State<ProfileEditTablefield> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            controller: widget.controller,
            labeltext: widget.text,
            focusNode: widget.focus,
            enabled: isEditing,
          ),
        ),
        SizedBox(width: 10.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isEditing ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            if (isEditing) {
              if (widget.isEmail) {
                context.read<SettingCubit>().changeEmail(
                  email: widget.controller.text,
                );
              }
            }

            setState(() {
              isEditing = !isEditing;
            });
            if (isEditing) {
              FocusScope.of(context).requestFocus(widget.focus);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          child: Text(
            isEditing ? "Save" : "Edit",
            style: AppTextStyle.giloryRegular16(context),
          ),
        ),
      ],
    );
  }
}
