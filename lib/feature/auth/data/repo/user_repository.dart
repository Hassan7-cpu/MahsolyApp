import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/feature/auth/data/models/login_model.dart';
import 'package:save_plant/feature/auth/data/models/signup_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});

  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        Endpoints.signIn,
        data: {ApiKey.email: email, ApiKey.password: password},
      );

      final data = response;

      if (data[ApiKey.access_token] == null ||
          data[ApiKey.access_token].toString().isEmpty) {
        final serverMsg =
            data[ApiKey.detail]?.toString() ?? 'Invalid credentials';

        return Left(serverMsg);
      }

      final user = SignInModel.fromJson(data);
      final token = user.token;

      if (token == null || token.isEmpty) {
        return Left("Invalid token");
      }

      final decoded = JwtDecoder.decode(token);
      final userId = decoded['sub']?.toString() ?? '';
      await CacheHelper().saveData(key: ApiKey.access_token, value: token);

      await CacheHelper().saveData(key: ApiKey.email, value: email);

      await CacheHelper().saveData(key: ApiKey.id, value: userId);
      final userName =
          decoded['name']?.toString() ?? decoded['username']?.toString() ?? '';
      if (userName.isNotEmpty) {
        await CacheHelper().saveData(key: ApiKey.name, value: userName);
      }

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("Something went wrong");
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        Endpoints.signUp,
        data: {
          ApiKey.name: name,
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      final signUPModel = SignUpModel.fromJson(response);
      await CacheHelper().saveData(key: ApiKey.name, value: name);
      return Right(signUPModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
