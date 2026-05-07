class UserState {}

class UserInitial extends UserState {}

class SignInSuccess extends UserState {
  final dynamic user;
  SignInSuccess({this.user});
}

class SignInNeedVerification extends UserState {
  final String email;
  final String message;

  SignInNeedVerification({required this.email, required this.message});
}

final class UploadProfilePic extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}
