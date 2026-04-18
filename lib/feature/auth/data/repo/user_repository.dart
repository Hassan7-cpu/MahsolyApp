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

      if (response[ApiKey.access_token] == null) {
        final serverMsg =
            response[ApiKey.detail] as String? ??
            response['message'] as String? ??
            'Please enter a valid email and password';
        return Left(serverMsg);
      }

      final user = SignInModel.fromJson(response);
      final token = user.token;

      if (token == null || token.isEmpty) {
        return Left("Please enter a valid email and password");
      }

      // ✅ هنا بالظبط
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['sub'] as String? ?? '';

      await CacheHelper().saveData(key: ApiKey.access_token, value: token);
      await CacheHelper().saveData(key: ApiKey.id, value: userId);

      print("✅ TOKEN: $token");
      print("✅ USER ID: $userId");

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      print("❌ signIn error: $e");
      return Left(e.toString());
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
      return Right(signUPModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
