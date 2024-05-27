import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/history/history_event.dart';
import 'package:penatu/app/bloc/history/history_state.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  HistoryBloc(this._mainRepository, this._localRepository)
      : super(InitialHistoryState()) {
    on<GetUserHistory>((event, emit) async {
      await _mapGetUserHistoryToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetUserHistoryToState() async {
    try {
      emit(LoadingHistoryState());
      emit(LoadedHistoryState());
    } catch (e, stackTrace) {
      emit(ErrorHistoryState('Terjadi Kesalahan', e.toString()));
    }
  }
}
