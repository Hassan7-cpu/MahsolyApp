import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/feature/auth/data/repo/otp_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/header_section.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/otp_view_body.dart';

class OtpView extends StatelessWidget {
  final String email;
  const OtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OtpCubit(OtpRepository(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        appBar: AppBar(title: const HeaderSection(title: 'OTP Verification')),
        body: OtpViewBody(email: email),
      ),
    );
  }
}
