import 'package:save_plant/core/networking/api_constant.dart';

class ForgotPasswordResponseModel {
  final String message;
  final String email;

  ForgotPasswordResponseModel({
    required this.message,
    required this.email,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      message: json[ApiKey.message] ?? json[ApiKey.detail] ?? '',
      email: json[ApiKey.email] ?? '',
    );
  }
}
