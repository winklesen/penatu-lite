import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/order/order_event.dart';
import 'package:penatu/app/bloc/order/order_state.dart';

import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  OrderBloc(this._mainRepository, this._localRepository)
      : super(InitialOrderState()) {
    on<PostUserOrder>((event, emit) async {
      await _mapPostUserOrderToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapPostUserOrderToState() async {
    try {
      emit(LoadingOrderState());

      emit(LoadedOrderState());
    } catch (e, stackTrace) {
      emit(ErrorOrderState('Terjadi Kesalahan', e.toString()));
    }
  }
}
