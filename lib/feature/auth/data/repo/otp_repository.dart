import 'package:dartz/dartz.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/feature/auth/data/models/otp_model.dart';

class OtpRepository {
  final ApiConsumer api;

  OtpRepository({required this.api});

  Future<Either<String, OtpModel>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await api.post(
        "${Endpoints.baseUrl}${Endpoints.verifyOtp}",
        data: {ApiKey.email: email, ApiKey.otp: otp},
      );

      final otpModel = OtpModel.fromJson(response);

      // ❗ هنا مفيش تخزين token إلا لو موجود فعلاً
      return Right(otpModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
