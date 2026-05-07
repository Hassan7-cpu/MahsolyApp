import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/auth/data/repo/confirm_email_otp_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/confirm_email_otp_state.dart';

class EmailOtpCubit extends Cubit<EmailOtpState> {
  final EmailOtpRepository repository;

  EmailOtpCubit(this.repository) : super(EmailOtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(EmailOtpLoading());

    final result = await repository.verifyEmailOtp(email: email, otp: otp);

    result.fold(
      (error) => emit(EmailOtpFailure(error)),
      (data) => emit(EmailOtpSuccess(data.message ?? "Success")),
    );
  }
}
