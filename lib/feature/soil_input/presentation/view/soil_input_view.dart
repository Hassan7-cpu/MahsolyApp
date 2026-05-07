import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/soil_input/data/repo/soil_repo.dart';
import 'package:save_plant/feature/soil_input/presentation/cubit/soil_cubit.dart';
import 'package:save_plant/feature/soil_input/presentation/view/widgets/soil_input_view_body.dart';

class SoilInputView extends StatelessWidget {
  const SoilInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SoilCubit(SoilRepo(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        appBar: AppBar(title: HeaderSection(title: "Soil Analysis")),
        body: SoilInputViewBody(),
      ),
    );
  }
}
