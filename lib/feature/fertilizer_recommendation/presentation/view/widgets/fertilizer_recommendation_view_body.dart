import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/widgets/build_section.dart';
import 'package:save_plant/core/widgets/custom_field.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/cubit/fertilizer_cubit.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/cubit/fertilizer_state.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/view/fertilizer_result.dart';

class FertilizerRecommendationViewBody extends StatefulWidget {
  const FertilizerRecommendationViewBody({super.key});

  @override
  State<FertilizerRecommendationViewBody> createState() =>
      _FertilizerRecommendationViewBodyState();
}

class _FertilizerRecommendationViewBodyState
    extends State<FertilizerRecommendationViewBody> {
  final formKey = GlobalKey<FormState>();

  final tempController = TextEditingController();
  final humidityController = TextEditingController();
  final moistureController = TextEditingController();

  final nitrogenController = TextEditingController();
  final potassiumController = TextEditingController();
  final phosphorousController = TextEditingController();

  String? selectedSoilType;
  String? selectedCropType;

  final List<String> soilTypes = ['Black', 'Clayey', 'Red', 'Loamy', 'Sandy'];

  final List<String> cropTypes = [
    'Paddy',
    'Tobacco',
    'Sugarcane',
    'Cotton',
    'Maize',
    'Wheat',
    'Barley',
    'Millets',
    'Pulses',
    'Oil seeds',
    'Ground Nuts',
  ];

  @override
  void dispose() {
    tempController.dispose();
    humidityController.dispose();
    moistureController.dispose();
    nitrogenController.dispose();
    potassiumController.dispose();
    phosphorousController.dispose();
    super.dispose();
  }

  void resetForm() {
    formKey.currentState?.reset();

    tempController.clear();
    humidityController.clear();
    moistureController.clear();
    nitrogenController.clear();
    potassiumController.clear();
    phosphorousController.clear();

    setState(() {
      selectedSoilType = null;
      selectedCropType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FertilizerCubit, FertilizerState>(
      listener: (context, state) {
        if (state is FertilizerSuccess) {
          snackBarMessage(context, 'Success', color: AppColor.primaryColor);

          resetForm();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FertilizerResultView(
                fertilizer: state.fertilizer,
                explanation: state.explanation,
              ),
            ),
          );
        } else if (state is FertilizerError) {
          snackBarMessage(context, state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            child: SafeArea(
              bottom: true,
              child: Column(
                children: [
                  BuildSection(
                    title: "Environment",
                    children: [
                      CustomField(
                        controller: tempController,
                        hint: "Temperature",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validateTemperature,
                        icon: Icons.thermostat,
                      ),
                      CustomField(
                        controller: humidityController,
                        hint: "Humidity",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validateHumidity,
                        icon: Icons.water_drop,
                      ),
                      CustomField(
                        controller: moistureController,
                        hint: "Moisture",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validateMoisture,
                        icon: Icons.opacity,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  BuildSection(
                    title: "Soil & Crop",
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedSoilType,
                        decoration: const InputDecoration(
                          hintText: "Soil Type",
                          prefixIcon: Icon(Icons.landscape),
                        ),
                        items: soilTypes
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSoilType = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? "Soil Type is required" : null,
                      ),

                      SizedBox(height: 12.h),

                      DropdownButtonFormField<String>(
                        value: selectedCropType,
                        decoration: const InputDecoration(
                          hintText: "Crop Type",
                          prefixIcon: Icon(Icons.agriculture),
                        ),
                        items: cropTypes
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCropType = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? "Crop Type is required" : null,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  BuildSection(
                    title: "Nutrients",
                    children: [
                      CustomField(
                        controller: nitrogenController,
                        hint: "Nitrogen",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validateNitrogen,
                        icon: Icons.eco,
                      ),
                      CustomField(
                        controller: phosphorousController,
                        hint: "Phosphorous",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validatePhosphorous,
                        icon: Icons.science,
                      ),
                      CustomField(
                        controller: potassiumController,
                        hint: "Potassium",
                        keyboardType: TextInputType.number,
                        validator: FertilizerValidators.validatePotassium,
                        icon: Icons.grass,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  CustomButton(
                    buttonText: 'Analyze',
                    isLoading: state is FertilizerLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<FertilizerCubit>().predictFertilizer(
                          temperature: tempController.text.trim(),
                          humidity: humidityController.text.trim(),
                          moisture: moistureController.text.trim(),
                          soilType: selectedSoilType!,
                          cropType: selectedCropType!,
                          nitrogen: nitrogenController.text.trim(),
                          potassium: potassiumController.text.trim(),
                          phosphorous: phosphorousController.text.trim(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
