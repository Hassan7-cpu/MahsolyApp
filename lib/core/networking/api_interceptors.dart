import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // You can add headers or modify the request here
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}