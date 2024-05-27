import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_event.dart';
import 'package:penatu/app/bloc/splash/splash_state.dart';
import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  SplashBloc(this._mainRepository, this._localRepository)
      : super(InitialSplashState()) {
    on<CheckAppVersion>((event, emit) async {
      await _mapCheckServerStatusToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapCheckServerStatusToState() async {
    try {
      log.i('12.emit(LoadingSplashState());');
      emit(LoadingSplashState());
    } catch (e, stackTrace) {

    }
  }
}
