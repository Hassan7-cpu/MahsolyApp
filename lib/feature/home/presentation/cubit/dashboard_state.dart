import 'package:save_plant/feature/home/data/model/dashboard_response_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final DashboardResponseModel response;
  DashboardSuccess({required this.response});
}

class DashboardFailure extends DashboardState {
  final String errMessage;
  DashboardFailure({required this.errMessage});
}
