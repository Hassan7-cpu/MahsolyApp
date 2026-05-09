class SoilResultModel {
  final String crop;
  final String explanation;

  SoilResultModel({required this.crop, required this.explanation});

  factory SoilResultModel.fromJson(Map<String, dynamic> data) {
    return SoilResultModel(
      crop: data['recommended_crop'] ?? '',
      explanation: data['explanation'] ?? '',
    );
  }
}
