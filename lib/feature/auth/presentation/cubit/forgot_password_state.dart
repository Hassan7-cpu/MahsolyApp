import 'package:save_plant/feature/auth/data/models/forgot_password_response_model.dart';
import 'package:save_plant/feature/auth/data/models/reset_password_response_model.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponseModel response;
  ForgotPasswordSuccess({required this.response});
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String errMessage;
  ForgotPasswordFailure({required this.errMessage});
}

class VerifyOtpLoading extends ForgotPasswordState {}

class VerifyOtpSuccess extends ForgotPasswordState {
  final ForgotPasswordResponseModel response;
  VerifyOtpSuccess({required this.response});
}

class VerifyOtpFailure extends ForgotPasswordState {
  final String errMessage;
  VerifyOtpFailure({required this.errMessage});
}

class ResetPasswordLoading extends ForgotPasswordState {}

class ResetPasswordSuccess extends ForgotPasswordState {
  final ResetPasswordResponseModel response;
  ResetPasswordSuccess({required this.response});
}

class ResetPasswordFailure extends ForgotPasswordState {
  final String errMessage;
  ResetPasswordFailure({required this.errMessage});
}
