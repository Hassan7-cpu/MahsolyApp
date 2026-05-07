import 'package:dartz/dartz.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/feature/auth/data/models/otp_model.dart';

class EmailOtpRepository {
  final ApiConsumer api;

  EmailOtpRepository({required this.api});

  Future<Either<String, OtpModel>> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await api.post(
        Endpoints.confirmOtp,
        data: {ApiKey.email: email, ApiKey.otp: otp},
      );

      return Right(OtpModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("Something went wrong");
    }
  }
}
