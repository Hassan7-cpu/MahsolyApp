// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/core/networking/api_constant.dart';

class PlantRepo {
  final ApiConsumer api;

  PlantRepo(this.api);

  Future<Either<String, dynamic>> uploadPlantImage(File image) async {
    try {
      final token = CacheHelper().getData(key: ApiKey.access_token) as String?;
      if (token == null || token.isEmpty) {
        return const Left("Please login first");
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
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return Left(
          data["message"]?.toString() ??
              data["detail"]?.toString() ??
              "Server error",
        );
      }

      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
