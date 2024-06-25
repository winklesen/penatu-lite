import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_event.dart';
import 'package:penatu/app/bloc/splash/splash_state.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';
import 'package:penatu/app/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Bloc
/// Contain business logic.
/// Called with event, return the state
/// tldr; bridge between event & state
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  SplashBloc(this._mainRepository, this._localRepository)
      : super(InitialSplashState()) {

    /// Handle bloc event call
    on<CheckSession>((event, emit) async {
      await _mapCheckSessionToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapCheckSessionToState() async {
    try {
      /// emit(statename) return bloc state
      emit(LoadingSplashState());

      GoTrueClient auth = await _mainRepository.getAuth();

      ///  is session empty?
      if (auth.currentUser == null) {
        emit(EmptySessionSplashState());
      } else {
        emit(LoggedInSplashState());
      }
    } catch (e, stackTrace) {
      emit(ErrorSplashState(errorTitle, e.toString()));
    }
  }
}
