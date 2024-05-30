import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_event.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_state.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  OrderDetailBloc(this._mainRepository, this._localRepository)
      : super(InitialOrderDetailState()) {
    on<GetOrderDetail>((event, emit) async {
      await _mapGetOrderDetailToState(event.orderId);
    });
    on<PutOrderStatus>((event, emit) async {
      await _mapPutOrderStatusToState(event.status, event.orderId);
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetOrderDetailToState(String orderId) async {
    try {
      emit(LoadingOrderDetailState());
      List<DetailPesanan> response =
      await _mainRepository.getPesananDetail(orderId);
      emit(LoadedOrderDetailState(response));
    } catch (e, stackTrace) {
      emit(ErrorOrderDetailState('Terjadi Kesalahan', e.toString()));
    }
  }

  Future<void> _mapPutOrderStatusToState(String status, String orderId) async {
    try {
      emit(LoadingOrderDetailState());
      await _mainRepository.putPesananStatus(orderId, status);
      emit(UpdatedOrderDetailState(status));
    } catch (e, stackTrace) {
      emit(ErrorOrderDetailState('Terjadi Kesalahan', e.toString()));
    }
  }
}
