import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'https://mahsoly-app-8ehw.vercel.app/';

  static const String signIn = 'auth/login';
  static String signUp = "auth/register";
  static String ChangeEmail = "auth/change-email";
  static String changePassword = "auth/change-password";
  static String verifyOtp = "auth/verify-otp";
  static String confirmOtp = "auth/confirm-email-otp";
  static String uploadImage = "scan";
  static String predictCrop = "predict-crop";
  static String predictFertilizer = "fertilizer-recommendation";
  static String chat = "chatbot";
  static String forgotPassword = "auth/forgot-password";
  static String verifyForgotPasswordOtp = "auth/verify-reset-otp";
  static String resetPassword = "auth/reset-password";
}

//دي الحاجات الي في ال response
class ApiKey {
  static String name = "name";
  static String email = "email";
  static String otp = "otp";
  static String password = "password";
  static String access_token = "access_token";
  static String detail = "message";
  static String id = "id";
  static String message = "message";
  static String reply = "reply";
  static String scanId = "scan_id";
  static String plantName = "plant_name";
  static String diseaseName = "disease_name";
  static String confidence = "confidence";
  static String imageUrl = "image_url";
  static String symptoms = "symptoms";
  static String treatment = "treatment";
  static String prevention = "prevention";
  static String tips = "tips";
  static String newPassword = "new_password";
  static String confirmPassword = "confirm_password";
}
