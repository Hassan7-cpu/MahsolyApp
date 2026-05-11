import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';
import 'package:save_plant/feature/camera/presentation/views/camera_view.dart';
import 'package:save_plant/feature/camera/presentation/views/plant_ai_result_view.dart';

class ResultView extends StatelessWidget {
  final ScanModel data;

  const ResultView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isError = data.diseaseName.isEmpty || data.confidence < 0.5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const HeaderSection(title: "Analysis Result"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: data.imageUrl.isNotEmpty
                              ? Image.network(data.imageUrl, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      if (isError) ...[
                        Text(
                          data.message,
                          style: AppTextStyle.giloryBold22(
                            context,
                          ).copyWith(color: Colors.red),
                        ),
                      ] else ...[
                        Text(
                          data.plantName,
                          style: AppTextStyle.giloryBold22(context),
                        ),

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
                      ],
                    ],
                  ),
                ),
              ),

              if (!isError)
                CustomButton(
                  buttonText: "Get Treatment Plan",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlantAiResultView(
                          plantName: data.plantName,
                          diseaseName: data.diseaseName,
                        ),
                      ),
                    );
                  },
                ),

              SizedBox(height: 20.h),
              CustomButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CameraView()),
                  );
                },
                buttonText: "Scan Another",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
