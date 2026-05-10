import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/core/widgets/custom_button.dart';
import 'package:save_plant/feature/soil_input/presentation/cubit/soil_cubit.dart';
import 'package:save_plant/feature/soil_input/presentation/cubit/soil_state.dart';
import 'package:save_plant/feature/soil_input/presentation/view/crop_result_view.dart';
import 'package:save_plant/core/widgets/build_section.dart';
import 'package:save_plant/core/widgets/custom_field.dart';

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

  void resetForm() {
    formKey.currentState!.reset();

    nController.clear();
    pController.clear();
    kController.clear();
    tempController.clear();
    humidityController.clear();
    phController.clear();
    rainfallController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoilCubit, SoilState>(
      listener: (context, state) {
        if (state is SoilSuccessState) {
          snackBarMessage(context, 'Suscess', color: AppColor.primaryColor);
          resetForm();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CropResultView(
                crop: state.crop,
                explanation: state.explanation,
              ),
            ),
          ).then((_) {
            resetForm();
          });
        } else if (state is SoilErrorState) {
          snackBarMessage(context, state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: SafeArea(
                  bottom: true,
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
                            validator: FarmValidators.validateNitrogen,
                          ),
                          CustomField(
                            hint: "Phosphorous (P)",
                            icon: Icons.science,
                            controller: pController,
                            keyboardType: TextInputType.number,
                            validator: FarmValidators.validatePhosphorous,
                          ),
                          CustomField(
                            hint: "Potassium (K)",
                            icon: Icons.grass,
                            controller: kController,
                            keyboardType: TextInputType.number,
                            validator: FarmValidators.validatePotassium,
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
                            validator: FarmValidators.validateTemperature,
                          ),
                          CustomField(
                            hint: "Humidity (%)",
                            icon: Icons.water_drop,
                            controller: humidityController,
                            keyboardType: TextInputType.number,
                            validator: FarmValidators.validateHumidity,
                          ),
                          CustomField(
                            hint: "Rainfall (mm)",
                            icon: Icons.cloud,
                            controller: rainfallController,
                            keyboardType: TextInputType.number,
                            validator: FarmValidators.validateRainfall,
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
                            validator: FarmValidators.validatePH,
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),
                      CustomButton(
                        buttonText: 'Analyze',
                        isLoading: state is SoilLoadingState,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SoilCubit>().analyzeSoil(
                              n: nController.text.trim(),
                              p: pController.text.trim(),
                              k: kController.text.trim(),
                              temp: tempController.text.trim(),
                              humidity: humidityController.text.trim(),
                              ph: phController.text.trim(),
                              rainfall: rainfallController.text.trim(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
