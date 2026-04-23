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
        '${Endpoints.baseUrl}${Endpoints.signIn}', // ❗ شيلنا المسافة
        data: {ApiKey.email: email, ApiKey.password: password},
      );

      // لو ApiConsumer بيرجع Response → استخدم .data
      final data = response;

      // ❗ لو مفيش token → error من السيرفر
      if (data[ApiKey.access_token] == null ||
          data[ApiKey.access_token].toString().isEmpty) {
        final serverMsg =
            data[ApiKey.detail]?.toString() ??
            data['message']?.toString() ??
            'Please enter a valid email and password';
        return Left(serverMsg);
      }

      final user = SignInModel.fromJson(data);

      final token = user.token;
      if (token == null || token.isEmpty) {
        return Left("Invalid token");
      }

      // decode token
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['sub']?.toString() ?? '';

      // ✅ خزّن التوكن صح
      await CacheHelper().saveData(key: ApiKey.access_token, value: token);

      await CacheHelper().saveData(key: ApiKey.id, value: userId);

      print("✅ TOKEN: $token");
      print("✅ USER ID: $userId");

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      print("❌ signIn error: $e");
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
        "${Endpoints.baseUrl}${Endpoints.signUp}",
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
