class FertilizerResultModel {
  final String predictedFertilizer;
  final String explanation;

  FertilizerResultModel({
    required this.predictedFertilizer,
    required this.explanation,
  });

  factory FertilizerResultModel.fromJson(Map<String, dynamic> json) {
    return FertilizerResultModel(
      predictedFertilizer: json["predicted_fertilizer"],
      explanation: json["explanation"],
    );
  }
}
