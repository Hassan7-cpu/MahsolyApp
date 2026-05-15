import 'package:save_plant/core/networking/api_constant.dart';

class ScanModel {
  final int? scanId;
  final String plantName;
  final String diseaseName;
  final double confidence;
  final String imageUrl;
  final String? symptoms;
  final String? treatment;
  final String? prevention;
  final String message;
  final List<String> tips;

  ScanModel({
    this.scanId,
    required this.plantName,
    required this.diseaseName,
    required this.confidence,
    required this.imageUrl,
    this.symptoms,
    this.treatment,
    this.prevention,
    required this.message,
    required this.tips,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      scanId: json[ApiKey.scanId],
      plantName: json[ApiKey.plantName] ?? "Unknown",
      diseaseName: json[ApiKey.diseaseName] ?? "Unknown",
      confidence: (json[ApiKey.confidence] as num?)?.toDouble() ?? 0.0,
      imageUrl: json[ApiKey.imageUrl] ?? "",
      symptoms: json[ApiKey.symptoms],
      treatment: json[ApiKey.treatment],
      prevention: json[ApiKey.prevention],
      message: json[ApiKey.message] ?? "",
      tips: (json[ApiKey.tips] as List?)?.cast<String>() ?? [],
    );
  }
}
