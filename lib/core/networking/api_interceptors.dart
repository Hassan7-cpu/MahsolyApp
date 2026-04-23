import 'package:dio/dio.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_constant.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper().getData(key: ApiKey.access_token);

    // 🧠 check if request is auth endpoint
    final isAuthRequest =
        options.path.contains(Endpoints.signIn) ||
        options.path.contains(Endpoints.signUp) ||
        options.path.contains(Endpoints.verifyOtp);

    // ✅ ضيف التوكن بس لو مش auth request
    if (!isAuthRequest &&
        token != null &&
        token.toString().isNotEmpty &&
        token != "null") {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
