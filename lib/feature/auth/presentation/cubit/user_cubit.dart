import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/auth/data/repo/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;

  UserCubit(this.repository) : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());

    try {
      final result = await repository.signIn(email: email, password: password);

      result.fold(
        (error) {
          // 👇 لو الحساب مش متفعل
          if (error.contains("Verify your account")) {
            emit(SignInNeedVerification(email: email, message: error));
          } else {
            emit(SignInFailure(errMessage: error));
          }
        },
        (user) {
          emit(SignInSuccess());
        },
      );
    } catch (e) {
      emit(SignInFailure(errMessage: "Something went wrong"));
      print("❌ Cubit signIn error: $e");
    }
  }

  // =========================
  // SIGN UP
  // =========================
  Future<void> signUp(String name, String email, String password) async {
    emit(SignUpLoading());

    try {
      final response = await repository.signUp(
        name: name,
        email: email,
        password: password,
      );

      response.fold(
        (errMessage) => emit(SignUpFailure(errMessage: errMessage)),
        (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
      );
    } catch (e) {
      emit(SignUpFailure(errMessage: "Something went wrong"));
    }
  }
}
