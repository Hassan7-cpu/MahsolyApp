import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/plant_build_section.dart';

class BuildContent extends StatelessWidget {
  final ScanModel data;

  const BuildContent({super.key, required this.data});

  List<String> cleanBulletText(String text) {
    return text
        .split('*')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((e) => e.replaceAll(RegExp(r'^[•\-\s]+'), ''))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.plantName, style: AppTextStyle.giloryBold22(context)),

        SizedBox(height: 12.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: AppDecoration.card(
            context,
          ).copyWith(color: Colors.red.shade200),
          child: Text(
            "Disease: ${data.diseaseName}",
            style: AppTextStyle.giloryRegular18(context),
          ),
        ),

        SizedBox(height: 16.h),

        if (data.symptoms != null && data.symptoms!.isNotEmpty)
          PlantBuildSection(
            title: "Symptoms",
            items: cleanBulletText(data.symptoms!),
            color: Colors.orange,
          ),

        if (data.treatment != null && data.treatment!.isNotEmpty)
          PlantBuildSection(
            title: "Treatment",
            items: cleanBulletText(data.treatment!),
            color: Colors.blue,
          ),

        if (data.prevention != null && data.prevention!.isNotEmpty)
          PlantBuildSection(
            title: "Prevention",
            items: cleanBulletText(data.prevention!),
            color: Colors.green,
          ),
      ],
    );
  }
}
