import 'package:dio/dio.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_constant.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper().getData(key: ApiKey.access_token);

    final authEndpoints = [
      Endpoints.signIn,
      Endpoints.signUp,
      Endpoints.verifyOtp,
      Endpoints.refreshToken,
    ];

    final isAuthRequest = authEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (!isAuthRequest &&
        token != null &&
        token.toString().isNotEmpty &&
        token.toString() != "null") {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
