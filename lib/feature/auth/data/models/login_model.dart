import 'package:save_plant/core/networking/api_constant.dart';

class SignInModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  SignInModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      accessToken: json[ApiKey.access_token] ?? '',
      refreshToken: json[ApiKey.refresh_token] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }
}
