abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess(this.message);
}

class OtpFailure extends OtpState {
  final String error;

  OtpFailure(this.error);
}
