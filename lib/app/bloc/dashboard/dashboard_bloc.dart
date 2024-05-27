import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_event.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_state.dart';
import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  DashboardBloc(this._mainRepository, this._localRepository)
      : super(InitialDashboardState()) {
    on<GetUserDashboard>((event, emit) async {
      await _mapGetUserDashboardToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetUserDashboardToState() async {
    try {
      emit(LoadingDashboardState());
      // emit(LoadedDashboardState());
    } catch (e, stackTrace) {
      emit(ErrorDashboardState('Terjadi Kesalahan', e.toString()));
    }
  }
}
