import 'package:dio/src/options.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
    Options? options,
  });
  Future<dynamic> patch(
    String Url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
  Future<dynamic> delete(
    String Url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
}
