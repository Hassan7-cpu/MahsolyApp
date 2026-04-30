class ScanModel {
  final String plantName;
  final String diseaseName;
  final double confidence;
  final String imageUrl;
  final String message;
  final List<String> tips;

  ScanModel({
    required this.plantName,
    required this.diseaseName,
    required this.confidence,
    required this.imageUrl,
    required this.message,
    required this.tips,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      plantName: json["plant_name"] ?? "",
      diseaseName: json["disease_name"] ?? "",
      confidence: (json["confidence"] ?? 0).toDouble(),
      imageUrl: json["image_url"] ?? "",
      message: json["message"] ?? "",
      tips: (json["tips"] as List?)?.cast<String>() ?? [],
    );
  }
}
