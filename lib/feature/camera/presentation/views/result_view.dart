import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';
import 'package:save_plant/feature/camera/presentation/views/camera_view.dart';

class ResultView extends StatelessWidget {
  final ScanModel data;

  const ResultView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isError = data.diseaseName.isEmpty;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HeaderSection(title: "Analysis Result"),
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
                              ? Image.network(
                                  data.imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 60.sp,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 60.sp,
                                  ),
                                ),
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

                        SizedBox(height: 12.h),

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.r),
                          decoration: AppDecoration.card(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: data.tips.map((tip) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Text("• $tip"),
                              );
                            }).toList(),
                          ),
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
                          child: Text("Disease: ${data.diseaseName}"),
                        ),

                        SizedBox(height: 12.h),

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.r),
                          decoration: AppDecoration.card(
                            context,
                          ).copyWith(color: Colors.blue.shade200),
                          child: Text(
                            "Confidence: ${(data.confidence * 100).toStringAsFixed(1)}%",
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              CustomButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraView()),
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
