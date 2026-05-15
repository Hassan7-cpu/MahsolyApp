import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';
import 'package:save_plant/feature/camera/presentation/views/camera_view.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/build_content.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/build_error.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/build_image.dart';
import 'package:save_plant/root.dart';

class ResultView extends StatelessWidget {
  final ScanModel data;

  const ResultView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isError = data.diseaseName.isEmpty || data.confidence < 0.5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const HeaderSection(title: "Detection Result"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Root()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildImage(data: data),
              SizedBox(height: 16.h),
              if (isError) BuildError(data: data) else BuildContent(data: data),
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
