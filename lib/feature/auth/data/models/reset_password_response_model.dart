import 'package:save_plant/core/networking/api_constant.dart';

class ResetPasswordResponseModel {
  final String message;

  ResetPasswordResponseModel({
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      message: json[ApiKey.message] ?? json[ApiKey.detail] ?? '',
    );
  }
}
