import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/plant_advisor_service.dart';
import 'package:save_plant/feature/camera/presentation/views/widgets/plant_build_section.dart';

class PlantAiResultView extends StatefulWidget {
  final String plantName;
  final String diseaseName;

  const PlantAiResultView({
    super.key,
    required this.plantName,
    required this.diseaseName,
  });

  @override
  State<PlantAiResultView> createState() => _PlantAiResultViewState();
}

class _PlantAiResultViewState extends State<PlantAiResultView> {
  final PlantAdvisorService _service = PlantAdvisorService();

  Map<String, dynamic> result = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAI();
  }

  Future<void> fetchAI() async {
    final res = await _service.analyzeDisease(
      widget.plantName,
      widget.diseaseName,
    );

    try {
      result = jsonDecode(res);
    } catch (_) {
      result = {};
    }

    setState(() {
      loading = false;
    });
  }

  List<String> getList(String key) {
    return List<String>.from(result[key] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final symptoms = getList("Symptoms");
    final causes = getList("Causes");
    final treatment = getList("Treatment");
    final prevention = getList("Prevention");

    return Scaffold(
      appBar: AppBar(title: Text("${widget.plantName} Doctor 🌱")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade700],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.diseaseName,
                          style: AppTextStyle.giloryBold18(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "AI Diagnosis Report",
                          style: AppTextStyle.giloryRegular14(
                            context,
                          ).copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  if (symptoms.isNotEmpty)
                    PlantBuildSection(
                      title: "Symptoms",
                      items: symptoms,
                      color: Colors.orange,
                    ),

                  if (causes.isNotEmpty)
                    PlantBuildSection(
                      title: "Causes",
                      items: causes,
                      color: Colors.red,
                    ),

                  if (treatment.isNotEmpty)
                    PlantBuildSection(
                      title: "Treatment",
                      items: treatment,
                      color: Colors.blue,
                    ),

                  if (prevention.isNotEmpty)
                    PlantBuildSection(
                      title: "Prevention",
                      items: prevention,
                      color: Colors.green,
                    ),
                ],
              ),
            ),
    );
  }
}
