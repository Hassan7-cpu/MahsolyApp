import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/auth/data/repo/setting_repository.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepository settingRepository;

  SettingCubit({required this.settingRepository}) : super(ChangeEmailInitial());

  Future<void> changeEmail({required String email}) async {
    emit(ChangeEmailLoading());

    final result = await settingRepository.changeEmail(newemail: email);

    result.fold(
      (error) => emit(ChangeEmailFailure(error)),
      (message) => emit(ChangeEmailSuccess(email)),
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(ChangePasswordLoading());

    final result = await settingRepository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );

    result.fold(
      (error) => emit(ChangePasswordFailure(error)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
