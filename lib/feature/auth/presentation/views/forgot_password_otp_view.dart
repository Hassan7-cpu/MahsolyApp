import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/widgets/header_section.dart';
import 'package:save_plant/feature/auth/data/repo/forgot_password_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/forgot_password_otp_view_body.dart';

class ForgotPasswordOtpView extends StatelessWidget {
  final String email;

  const ForgotPasswordOtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        ForgotPasswordRepository(api: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const HeaderSection(title: "OTP Verification"),
        ),
        body: ForgotPasswordOtpViewBody(email: email),
      ),
    );
  }
}
