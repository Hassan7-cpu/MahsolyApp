import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';

class ResultView extends StatelessWidget {
  final ScanModel data;

  const ResultView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Result")),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                data.imageUrl,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 200.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 200.h,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 60),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
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
                style: TextStyle(fontSize: 16.sp),
              ),
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
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
