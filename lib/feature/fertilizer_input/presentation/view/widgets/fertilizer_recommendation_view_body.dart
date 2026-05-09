import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/widgets/build_section.dart';
import 'package:save_plant/core/widgets/custom_field.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/fertilizer_input/presentation/cubit/fertilizer_cubit.dart';
import 'package:save_plant/feature/fertilizer_input/presentation/cubit/fertilizer_state.dart';
import 'package:save_plant/feature/fertilizer_input/presentation/view/fertilizer_result.dart';

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

  final soilTypeController = TextEditingController();
  final cropTypeController = TextEditingController();

  @override
  void dispose() {
    tempController.dispose();
    humidityController.dispose();
    moistureController.dispose();
    nitrogenController.dispose();
    potassiumController.dispose();
    phosphorousController.dispose();
    soilTypeController.dispose();
    cropTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FertilizerCubit, FertilizerState>(
      listener: (context, state) {
        if (state is FertilizerSuccess) {
          snackBarMessage(context, 'Suscess', color: AppColor.primaryColor);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FertilizerResultView(
                fertilizer: state.fertilizer,
                explanation: state.explanation,
              ),
            ),
          );
        }

        if (state is FertilizerError) {
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
                        validator: FarmValidators.validateTemperature,
                        icon: Icons.thermostat,
                      ),
                      CustomField(
                        controller: humidityController,
                        hint: "Humidity",
                        keyboardType: TextInputType.number,
                        validator: FarmValidators.validateHumidity,
                        icon: Icons.water_drop,
                      ),
                      CustomField(
                        controller: moistureController,
                        hint: "Moisture",
                        keyboardType: TextInputType.number,
                        validator: FarmValidators.validateMoisture,
                        icon: Icons.opacity,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  BuildSection(
                    title: "Soil & Crop",
                    children: [
                      CustomField(
                        controller: soilTypeController,
                        hint: "Soil Type",
                        keyboardType: TextInputType.text,
                        validator: FarmValidators.validateRequired,
                        icon: Icons.landscape,
                      ),
                      CustomField(
                        controller: cropTypeController,
                        hint: "Crop Type",
                        keyboardType: TextInputType.text,
                        validator: FarmValidators.validateRequired,
                        icon: Icons.agriculture,
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
                        validator: FarmValidators.validateNitrogen,
                        icon: Icons.eco,
                      ),
                      CustomField(
                        controller: phosphorousController,
                        hint: "Phosphorous",
                        keyboardType: TextInputType.number,
                        validator: FarmValidators.validatePhosphorous,
                        icon: Icons.science,
                      ),
                      CustomField(
                        controller: potassiumController,
                        hint: "Potassium",
                        keyboardType: TextInputType.number,
                        validator: FarmValidators.validatePotassium,
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
                          temperature: tempController.text,
                          humidity: humidityController.text,
                          moisture: moistureController.text,
                          soilType: soilTypeController.text,
                          cropType: cropTypeController.text,
                          nitrogen: nitrogenController.text,
                          potassium: potassiumController.text,
                          phosphorous: phosphorousController.text,
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
