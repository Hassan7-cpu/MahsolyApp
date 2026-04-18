abstract class UploadPlantImageState {}

class UploadPlantImageInitial extends UploadPlantImageState {}

class UploadPlantImageLoading extends UploadPlantImageState {}

class UploadPlantImageSuccess extends UploadPlantImageState {
  final dynamic data;
  UploadPlantImageSuccess(this.data);
}

class UploadPlantImageError extends UploadPlantImageState {
  final String message;
  UploadPlantImageError(this.message);
}
