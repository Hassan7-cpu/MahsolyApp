import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/auth/data/repo/confirm_email_otp_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/confirm_email_otp_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/confirm_email_view_body.dart';

class ConfirmEmailView extends StatelessWidget {
  final String email;
  const ConfirmEmailView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmailOtpCubit(EmailOtpRepository(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        appBar: AppBar(title: const HeaderSection(title: 'Confirm Otp')),
        body: ConfirmEmailViewBody(email: email),
      ),
    );
  }
}
