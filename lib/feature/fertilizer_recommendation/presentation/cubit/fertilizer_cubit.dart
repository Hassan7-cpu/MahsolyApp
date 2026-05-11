import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/fertilizer_recommendation/data/repo/fertilizer_repo.dart';
import 'fertilizer_state.dart';

class FertilizerCubit extends Cubit<FertilizerState> {
  FertilizerCubit(this.repo) : super(FertilizerInitial());

  final FertilizerRepo repo;

  Future<void> predictFertilizer({
    required String temperature,
    required String humidity,
    required String moisture,
    required String soilType,
    required String cropType,
    required String nitrogen,
    required String potassium,
    required String phosphorous,
  }) async {
    emit(FertilizerLoading());

    final result = await repo.predictFertilizer(
      temperature: temperature,
      humidity: humidity,
      moisture: moisture,
      soilType: soilType,
      cropType: cropType,
      nitrogen: nitrogen,
      potassium: potassium,
      phosphorous: phosphorous,
    );

    result.fold(
      (error) {
        emit(FertilizerError(error.errorMessage));
      },
      (data) {
        emit(
          FertilizerSuccess(
            fertilizer: data.predictedFertilizer,
            explanation: data.explanation,
          ),
        );
      },
    );
  }
}
