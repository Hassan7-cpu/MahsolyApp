import 'package:dartz/dartz.dart';
import 'package:save_plant/core/errors/exceptions.dart';
import 'package:save_plant/core/networking/api_constant.dart';
import 'package:save_plant/core/networking/api_consumer.dart';
import 'package:save_plant/feature/home/data/model/dashboard_response_model.dart';

class DashboardRepository {
  final ApiConsumer api;

  DashboardRepository({required this.api});

  Future<Either<String, DashboardResponseModel>> getDashboardUrl() async {
    try {
      final response = await api.get(Endpoints.dashboard);

      if (response != null && response is Map) {
        final model = DashboardResponseModel.fromJson(Map<String, dynamic>.from(response));
        if (model.url.isNotEmpty) {
          return Right(model);
        } else {
          return const Left("Dashboard URL is empty");
        }
      } else {
        return const Left("Invalid response from server");
      }
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
