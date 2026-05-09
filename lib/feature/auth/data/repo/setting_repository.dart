import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';

class SettingRepository {
  final ApiConsumer api;

  SettingRepository({required this.api});

  Future<Either<String, void>> changeEmail({required String newemail}) async {
    try {
      final token = CacheHelper().getData(key: ApiKey.access_token);

      final response = await api.post(
        Endpoints.ChangeEmail,
        data: {"new_email": newemail},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response == null) {
        return const Left("Unexpected error");
      }

      // sync cache
      await CacheHelper().saveData(key: ApiKey.email, value: newemail);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return const Left("Unexpected error");
    }
  }

  Future<Either<String, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final token = CacheHelper().getData(key: ApiKey.access_token);

      final response = await api.put(
        Endpoints.changePassword,
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_new_password": confirmNewPassword,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
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
