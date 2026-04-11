// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_interceptors.dart';
import 'package:save_plant/core/networking/api_services.dart';

class DioClient extends ApiServices {
  final Dio dio;

  DioClient({required this.dio}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final Response = await dio.delete(
        path,
        data: isFromData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        queryParameters: queryParameters,
      );
      return Response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response = await dio.get(path, queryParameters: queryParameters);
      return Response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final Response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return Response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final Response = await dio.post(
        path,
        data: isFromData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        queryParameters: queryParameters,
      );
      return Response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }
}
