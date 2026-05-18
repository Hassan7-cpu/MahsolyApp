import 'package:dartz/dartz.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
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

      print("Change email response: $response");

      await CacheHelper().saveData(key: ApiKey.email, value: newemail);

      return const Right(null);
    } on ServerException catch (e) {
      print("Change email server exception: ${e.errModel.errorMessage}");

      return Left(e.errModel.errorMessage);
    } catch (e) {
      print("Change email unexpected error: $e");

      return const Left("Unexpected error");
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

      print("Change password response: $response");

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }
}
