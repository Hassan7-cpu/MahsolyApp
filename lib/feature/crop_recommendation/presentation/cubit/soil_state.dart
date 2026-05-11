class SoilState {}

class InitialState extends SoilState {}

class SoilLoadingState extends SoilState {}

class SoilSuccessState extends SoilState {
  final String crop;
  final String explanation;

  SoilSuccessState({required this.crop, required this.explanation});
}

class SoilErrorState extends SoilState {
  final String errorMessage;
  SoilErrorState({required this.errorMessage});
}
