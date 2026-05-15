import 'package:dartz/dartz.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';

class ChatService {
  final ApiConsumer api;

  ChatService({required this.api});

  Future<Either<String, dynamic>> sendMessage({required String message}) async {
    try {
      final response = await api.post(
        Endpoints.chat,
        data: {ApiKey.message: message},
      );

      return Right(response);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("Something went wrong");
    }
  }
}
