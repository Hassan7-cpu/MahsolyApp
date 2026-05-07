import 'package:dartz/dartz.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';

class SettingRepository {
  final ApiConsumer api;
  SettingRepository({required this.api});

  Future<Either<String, void>> changeEmail({required String newemail}) async {
    try {
      final response = await api.post(
        Endpoints.ChangeEmail,
        data: {"new_email": newemail},
      );

      final data = response;

      if (data == null) {
        return const Left("Unexpected error");
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("Unexpected error");
    }
  }

  Future<Either<String, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await api.put(
        Endpoints.changePassword,
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_new_password": confirmNewPassword,
        },
      );

      if (response == null) {
        return const Left("Unexpected error");
      }

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }
}
