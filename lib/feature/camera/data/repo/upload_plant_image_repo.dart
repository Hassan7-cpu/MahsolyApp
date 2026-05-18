// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/errors/exceptions.dart';
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

          extra: {"filePath": image.path},
        ),
      );

      return Right(response);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
