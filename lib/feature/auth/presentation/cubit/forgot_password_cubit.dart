import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/auth/data/repo/forgot_password_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository repository;

  ForgotPasswordCubit(this.repository) : super(ForgotPasswordInitial());

  Future<void> forgotPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await repository.forgotPassword(email: email);
    result.fold(
      (failure) => emit(ForgotPasswordFailure(errMessage: failure)),
      (success) => emit(ForgotPasswordSuccess(response: success)),
    );
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(VerifyOtpLoading());
    final result = await repository.verifyForgotPasswordOtp(
      email: email,
      otp: otp,
    );
    result.fold(
      (failure) => emit(VerifyOtpFailure(errMessage: failure)),
      (success) => emit(VerifyOtpSuccess(response: success)),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());
    final result = await repository.resetPassword(
      email: email,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (failure) => emit(ResetPasswordFailure(errMessage: failure)),
      (success) => emit(ResetPasswordSuccess(response: success)),
    );
  }
}
