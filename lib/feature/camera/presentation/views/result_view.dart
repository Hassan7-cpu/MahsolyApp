import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  // final Map<String, dynamic> result;

  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Result")),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            // صورة
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              // child: Image.network(['image']),
            ),

            SizedBox(height: 16.h),

            // اسم النبات
            Text(
              'ssss',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12.h),

            // الحالة
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.green.shade100,

                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            // نسبة الثقة
          ],
        ),
      ),
    );
  }
}
