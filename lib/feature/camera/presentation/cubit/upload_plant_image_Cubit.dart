import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/camera/data/repo/upload_plant_image_repo.dart';
import 'package:save_plant/feature/camera/presentation/cubit/upload_plant_image_state.dart';

class UploadPlantImageCubit extends Cubit<UploadPlantImageState> {
  final PlantRepo repo;

  UploadPlantImageCubit(this.repo) : super(UploadPlantImageInitial());

  Future<void> uploadImage(File image) async {
    emit(UploadPlantImageLoading());

    final result = await repo.uploadPlantImage(image);

    result.fold(
      (error) => emit(UploadPlantImageError(error)),
      (data) => emit(UploadPlantImageSuccess(data)),
    );
  }
}
