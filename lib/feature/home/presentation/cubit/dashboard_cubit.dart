import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_plant/feature/home/data/repo/dashboard_repository.dart';
import 'package:save_plant/feature/home/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit(this.repository) : super(DashboardInitial());

  Future<void> fetchDashboardUrl() async {
    emit(DashboardLoading());
    final result = await repository.getDashboardUrl();
    result.fold(
      (failure) => emit(DashboardFailure(errMessage: failure)),
      (success) => emit(DashboardSuccess(response: success)),
    );
  }
}
