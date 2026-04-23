import 'package:save_plant/core/networking/api_constant.dart';

class OtpModel {
  final String accessToken;
  final String? message;

  OtpModel({required this.accessToken, this.message});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      accessToken: json[ApiKey.access_token] ?? '',
      message: json[ApiKey.detail],
    );
  }
}
