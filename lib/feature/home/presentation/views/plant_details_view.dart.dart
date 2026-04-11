import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/home/data/model/item_model.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/build_feature_card.dart';
import 'package:save_plant/feature/home/presentation/views/widgets/header_image.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(item: item),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(item.name, style: AppTextStyle.gilorybold30(context)),
                  SizedBox(height: 24.h),
                  BuildFeatureCard(
                    icon: Icons.water_drop,
                    title: "Watering",
                    subtitle: item.waterNeeds,
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: 16.h),
                  BuildFeatureCard(
                    icon: Icons.wb_sunny,
                    title: "Sunlight",
                    subtitle: item.sunNeeds,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 16.h),
                  BuildFeatureCard(
                    icon: Icons.grass,
                    title: "Soil",
                    subtitle: item.soilNeeds,
                    color: Colors.brown,
                  ),
                  SizedBox(height: 16.h),
                  BuildFeatureCard(
                    icon: Icons.bug_report,
                    title: "Common Disease",
                    subtitle: item.commonDisease,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 16.h),
                  BuildFeatureCard(
                    icon: Icons.calendar_month,
                    title: "Season",
                    subtitle: item.season,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
