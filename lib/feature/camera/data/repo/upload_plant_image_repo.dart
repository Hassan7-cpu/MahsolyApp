import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/cache/cache_helper.dart'; // ✅ أضف الاستيراد

class PlantRepo {
  final ApiConsumer api;

  PlantRepo(this.api);

  Future<Either<String, dynamic>> uploadPlantImage(File image) async {
    try {
      // ✅ جيب التوكن من الكاش
      final token = CacheHelper().getData(key: ApiKey.access_token) as String?;
      print("🔑 TOKEN USED: $token");

      if (token == null || token.isEmpty) {
        return Left("Please login first");
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
            "Authorization": "Bearer $token", // ✅ التوكن هنا
          },
        ),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left("Session expired, please login again");
      }
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return Left(data["message"] ?? data["detail"] ?? "Server error");
      }
      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
