import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/auth/data/repo/otp_repository.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepository otpRepository;

  OtpCubit(this.otpRepository) : super(OtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(OtpLoading());

    final result = await otpRepository.verifyOtp(email: email, otp: otp);

    result.fold(
      (error) {
        // ❌ failure
        emit(OtpFailure(error));
      },
      (success) {
        // ✅ success
        emit(OtpSuccess("Account verified successfully"));
      },
    );
  }
}
