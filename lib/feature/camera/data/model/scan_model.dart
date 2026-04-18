class ScanModel {
  final int scanId;
  final String plantName;
  final String diseaseName;
  final double confidence;
  final String imageUrl;

  ScanModel({
    required this.scanId,
    required this.plantName,
    required this.diseaseName,
    required this.confidence,
    required this.imageUrl,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      scanId: json["scan_id"],
      plantName: json["plant_name"],
      diseaseName: json["disease_name"],
      confidence: (json["confidence"] as num).toDouble(),
      imageUrl: json["image_url"],
    );
  }
}
