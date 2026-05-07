import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';

class ProfileHeaderCard extends StatefulWidget {
  const ProfileHeaderCard({super.key, required this.name});
  final String name;

  @override
  State<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<ProfileHeaderCard> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> logout() async {
    await CacheHelper().removeData(key: ApiKey.access_token);
    await CacheHelper().removeData(key: ApiKey.id);

    if (!mounted) return;

    snackBarMessage(context, "Logged out successfully", color: Colors.green);

    await Future.delayed(const Duration(milliseconds: 300));

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: AppDecoration.card(context),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(CupertinoIcons.person, color: AppColor.primaryColor),
              SizedBox(width: 12.w),
              Text(
                "Personal Information",
                style: AppTextStyle.giloryBold18(context),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.person, size: 50.sp, color: Colors.grey)
                        : null,
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Text(
                  widget.name,
                  style: AppTextStyle.giloryBold18(context),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          PersonalInfoCard(),

          SizedBox(height: 20.h),

          CustomButtonAuth(buttonText: 'Logout', onPressed: logout),
        ],
      ),
    );
  }
}
