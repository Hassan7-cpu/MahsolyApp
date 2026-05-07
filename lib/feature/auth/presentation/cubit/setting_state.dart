class SettingState {}

class ChangeEmailInitial extends SettingState {}

class ChangeEmailLoading extends SettingState {}

class ChangeEmailSuccess extends SettingState {
  final String email;

  ChangeEmailSuccess(this.email);
}

class ChangeEmailFailure extends SettingState {
  final String error;
  ChangeEmailFailure(this.error);
}

class ChangePasswordInitial extends SettingState {}

class ChangePasswordLoading extends SettingState {}

class ChangePasswordSuccess extends SettingState {}

class ChangePasswordFailure extends SettingState {
  final String errMessage;
  ChangePasswordFailure(this.errMessage);
}
