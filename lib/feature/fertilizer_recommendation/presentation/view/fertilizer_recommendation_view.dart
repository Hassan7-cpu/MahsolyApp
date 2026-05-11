import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/fertilizer_recommendation/data/repo/fertilizer_repo.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/cubit/fertilizer_cubit.dart';
import 'package:save_plant/feature/fertilizer_recommendation/presentation/view/widgets/fertilizer_recommendation_view_body.dart';

class FertilizerRecommendationView extends StatelessWidget {
  const FertilizerRecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FertilizerCubit(FertilizerRepo(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: HeaderSection(title: "Fertilizer AI"),
        ),
        body: FertilizerRecommendationViewBody(),
      ),
    );
  }
}
