import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/dio_consumer.dart';
import 'package:save_plant/core/errors/error_model.dart';
import 'package:save_plant/feature/crop_recommendation/data/model/soil_model.dart';

class SoilRepo {
  final DioConsumer api;

  SoilRepo({required this.api});

  Future<Either<ErrorModel, SoilResultModel>> analyzeSoil({
    required String n,
    required String p,
    required String k,
    required String temp,
    required String humidity,
    required String ph,
    required String rainfall,
  }) async {
    try {
      final response = await api.post(
        Endpoints.predictCrop,
        data: {
          "N": _toDouble(n),
          "P": _toDouble(p),
          "K": _toDouble(k),
          "temperature": _toDouble(temp),
          "humidity": _toDouble(humidity),
          "ph": _toDouble(ph),
          "rainfall": _toDouble(rainfall),
        },
      );

      final model = SoilResultModel.fromJson(response);

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
