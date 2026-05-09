import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/soil_input/data/repo/soil_repo.dart';
import 'package:save_plant/feature/soil_input/presentation/cubit/soil_state.dart';

class SoilCubit extends Cubit<SoilState> {
  SoilCubit(this.repo) : super(InitialState());

  final SoilRepo repo;

  Future<void> analyzeSoil({
    required String n,
    required String p,
    required String k,
    required String temp,
    required String humidity,
    required String ph,
    required String rainfall,
  }) async {
    emit(SoilLoadingState());

    final result = await repo.analyzeSoil(
      n: n,
      p: p,
      k: k,
      temp: temp,
      humidity: humidity,
      ph: ph,
      rainfall: rainfall,
    );

    result.fold(
      (error) {
        emit(SoilErrorState(errorMessage: error.errorMessage));
      },
      (data) {
        emit(SoilSuccessState(crop: data.crop, explanation: data.explanation));
      },
    );
  }
}
