import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/errors/error_model.dart';
import 'package:save_plant/feature/fertilizer_recommendation/data/model/firtilizer_model.dart';

class FertilizerRepo {
  final DioConsumer api;

  FertilizerRepo({required this.api});

  Future<Either<ErrorModel, FertilizerResultModel>> predictFertilizer({
    required String temperature,
    required String humidity,
    required String moisture,
    required String soilType,
    required String cropType,
    required String nitrogen,
    required String potassium,
    required String phosphorous,
  }) async {
    try {
      final response = await api.post(
        Endpoints.predictFertilizer,

        data: {
          "Temparature": _toDouble(temperature),
          "Humidity": _toDouble(humidity),
          "Moisture": _toDouble(moisture),
          "Soil_Type": soilType.trim(),
          "Crop_Type": cropType.trim(),
          "Nitrogen": _toDouble(nitrogen),
          "Potassium": _toDouble(potassium),
          "Phosphorous": _toDouble(phosphorous),
        },
      );

      final model = FertilizerResultModel.fromJson(response);

      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errModel);
    } on DioException catch (e) {
      return Left(
        ErrorModel(errorMessage: e.message ?? "Network error occurred"),
      );
    } catch (e) {
      return Left(ErrorModel(errorMessage: "Unexpected error occurred"));
    }
  }

  double _toDouble(String value) {
    return double.tryParse(value.trim()) ?? 0.0;
  }
}
