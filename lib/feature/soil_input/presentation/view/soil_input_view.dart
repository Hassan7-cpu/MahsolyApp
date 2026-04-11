import 'package:flutter/material.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/soil_input/presentation/view/widgets/soil_input_view_body.dart';

class SoilInputView extends StatelessWidget {
  const SoilInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(title: HeaderSection(title: "Soil Analysis")),
        body: SoilInputViewBody(),
      ),
    );
  }
}
