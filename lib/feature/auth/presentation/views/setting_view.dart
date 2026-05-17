// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/auth/data/repo/setting_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/setting_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(
        settingRepository: SettingRepository(api: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(title: const HeaderSection(title: "Profile")),
        body: const SettingViewBody(),
      ),
    );
  }
}
