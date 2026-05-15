class Endpoints {
  static const String baseUrl = 'https://mahsoly-app-8ehw.vercel.app/';
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
}
