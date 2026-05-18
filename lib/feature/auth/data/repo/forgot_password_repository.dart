import 'package:dartz/dartz.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/feature/auth/data/models/forgot_password_response_model.dart';
import 'package:save_plant/feature/auth/data/models/reset_password_response_model.dart';

class ForgotPasswordRepository {
  final ApiConsumer api;

  ForgotPasswordRepository({required this.api});

  Future<Either<String, ForgotPasswordResponseModel>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await api.post(
        Endpoints.forgotPassword,
        data: {ApiKey.email: email},
      );

      final model = ForgotPasswordResponseModel.fromJson(response);
      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ForgotPasswordResponseModel>> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await api.post(
        Endpoints.verifyForgotPasswordOtp,
        data: {ApiKey.email: email, ApiKey.otp: otp},
      );

      final model = ForgotPasswordResponseModel.fromJson(response);
      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ResetPasswordResponseModel>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await api.post(
        Endpoints.resetPassword,
        data: {
          ApiKey.email: email,
          ApiKey.newPassword: newPassword,
          ApiKey.confirmPassword: confirmPassword,
        },
      );

      final model = ResetPasswordResponseModel.fromJson(response);
      return Right(model);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
