import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/feature/home/data/model/item_model.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: item.name,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.382,
            decoration: BoxDecoration(
              image: DecorationImage(image: item.image, fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.lightBackground.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16.w,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColor.lightBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.darkBackground,
                size: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
