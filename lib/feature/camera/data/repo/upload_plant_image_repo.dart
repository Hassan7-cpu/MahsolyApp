// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/cache/cache_helper.dart';

class PlantRepo {
  final ApiConsumer api;

  PlantRepo(this.api);

  Future<Either<String, dynamic>> uploadPlantImage(File image) async {
    try {
      final token = CacheHelper().getData(key: ApiKey.access_token) as String?;

      print("🔑 TOKEN USED: $token");

      if (token == null || token.isEmpty) {
        return Left("Please login first");
      }

      if (JwtDecoder.isExpired(token)) {
        await CacheHelper().removeData(key: ApiKey.access_token);
        return Left("Session expired, please login again");
      }

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: "plant.jpg"),
      });

      final response = await api.post(
        Endpoints.uploadImage,
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {
            "accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return Right(response);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;

      if (status == 401) {
        await CacheHelper().removeData(key: ApiKey.access_token);

        final msg = (data is Map<String, dynamic>)
            ? (data["detail"] ?? data["message"])
            : null;

        if (msg != null && msg.toString().toLowerCase().contains("auth")) {
          return Left("Session expired, please login again");
        }

        return Left("Unauthorized, please login again");
      }

      if (data is Map<String, dynamic>) {
        return Left(data["message"] ?? data["detail"] ?? "Server error");
      }

      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
