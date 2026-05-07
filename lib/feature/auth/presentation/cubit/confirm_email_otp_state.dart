abstract class EmailOtpState {}

class EmailOtpInitial extends EmailOtpState {}

class EmailOtpLoading extends EmailOtpState {}

class EmailOtpSuccess extends EmailOtpState {
  final String message;

  EmailOtpSuccess(this.message);
}

class EmailOtpFailure extends EmailOtpState {
  final String error;

  EmailOtpFailure(this.error);
}
