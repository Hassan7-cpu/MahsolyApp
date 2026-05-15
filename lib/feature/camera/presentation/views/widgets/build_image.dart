import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/feature/camera/data/model/scan_model.dart';

class BuildImage extends StatelessWidget {
  final ScanModel data;
  const BuildImage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: data.imageUrl.isNotEmpty
            ? Image.network(
                data.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Center(child: Icon(Icons.image_not_supported, size: 60.sp)),
      ),
    );
  }
}
