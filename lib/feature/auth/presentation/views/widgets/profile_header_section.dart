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
import 'package:save_plant/core/theme/cubit/theme_cubit.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/auth/presentation/views/login_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/personal_info.dart';

class ProfileHeaderCard extends StatefulWidget {
  const ProfileHeaderCard({super.key});

  @override
  State<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<ProfileHeaderCard> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File tempImage = File(pickedFile.path);

      await CacheHelper().saveData(key: "profile_image", value: tempImage.path);

      setState(() {
        _image = tempImage;
      });
    }
  }

  Future<void> _loadImage() async {
    final path = CacheHelper().getData(key: "profile_image");

    if (path != null) {
      final file = File(path);

      if (await file.exists()) {
        setState(() {
          _image = file;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> logout() async {
    await CacheHelper().removeData(key: ApiKey.access_token);
    await CacheHelper().removeData(key: ApiKey.id);
    await CacheHelper().removeData(key: ApiKey.email);
    final themeCubit = ThemeCubit.get(context);
    themeCubit.reset();

    if (!mounted) return;

    snackBarMessage(context, "Logged out successfully", color: Colors.green);

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
                    color: AppColor.primaryColor,
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
          SizedBox(height: 20.h),

          PersonalInfoCard(),

          SizedBox(height: 20.h),
          CustomButtonAuth(buttonText: 'Logout', onPressed: logout),
        ],
      ),
    );
  }
}
