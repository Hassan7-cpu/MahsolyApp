abstract class FertilizerState {}

class FertilizerInitial extends FertilizerState {}

class FertilizerLoading extends FertilizerState {}

class FertilizerSuccess extends FertilizerState {
  final String fertilizer;
  final String explanation;

  FertilizerSuccess({required this.fertilizer, required this.explanation});
}

class FertilizerError extends FertilizerState {
  final String message;

  FertilizerError(this.message);
}
