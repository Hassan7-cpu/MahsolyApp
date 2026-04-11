import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/soil_input/presentation/view/widgets/build_section.dart';
import 'package:save_plant/feature/soil_input/presentation/view/widgets/custom_field.dart';

class SoilInputViewBody extends StatefulWidget {
  const SoilInputViewBody({super.key});

  @override
  State<SoilInputViewBody> createState() => _SoilInputViewBodyState();
}

class _SoilInputViewBodyState extends State<SoilInputViewBody> {
  final formKey = GlobalKey<FormState>();

  final nController = TextEditingController();
  final pController = TextEditingController();
  final kController = TextEditingController();
  final tempController = TextEditingController();
  final humidityController = TextEditingController();
  final phController = TextEditingController();
  final rainfallController = TextEditingController();

  @override
  void dispose() {
    nController.dispose();
    pController.dispose();
    kController.dispose();
    tempController.dispose();
    humidityController.dispose();
    phController.dispose();
    rainfallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            BuildSection(
              title: "Nutrients",
              children: [
                CustomField(
                  hint: "Nitrogen (N)",
                  icon: Icons.eco,
                  controller: nController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                CustomField(
                  hint: "Phosphorous (P)",
                  icon: Icons.science,
                  controller: pController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                CustomField(
                  hint: "Potassium (K)",
                  icon: Icons.grass,
                  controller: kController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            BuildSection(
              title: "Environment",
              children: [
                CustomField(
                  hint: "Temperature (°C)",
                  icon: Icons.thermostat,
                  controller: tempController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                CustomField(
                  hint: "Humidity (%)",
                  icon: Icons.water_drop,
                  controller: humidityController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
                CustomField(
                  hint: "Rainfall (mm)",
                  icon: Icons.cloud,
                  controller: rainfallController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            BuildSection(
              title: "Soil",
              children: [
                CustomField(
                  hint: "pH Value",
                  icon: Icons.biotech,
                  controller: phController,
                  keyboardType: TextInputType.number,
                  validator: validateNumber,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: CustomButton(onPressed: () {}, buttonText: "Analyze"),
            ),
          ],
        ),
      ),
    );
  }
}
