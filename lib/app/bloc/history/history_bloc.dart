import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/history/history_event.dart';
import 'package:penatu/app/bloc/history/history_state.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  HistoryBloc(this._mainRepository, this._localRepository)
      : super(InitialHistoryState()) {
    on<GetOrderHistory>((event, emit) async {
      await _mapGetOrderHistoryToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetOrderHistoryToState() async {
    try {
      emit(LoadingHistoryState());

      String? userId = await _mainRepository.getUserSessionId();
      List<Pesanan> response =
          await _mainRepository.getPesananByStatus(userId!);

      response = response.reversed.toList();
      emit(LoadedHistoryState(response));
    } catch (e, stackTrace) {
      emit(ErrorHistoryState('Terjadi Kesalahan', e.toString()));
    }
  }
}
