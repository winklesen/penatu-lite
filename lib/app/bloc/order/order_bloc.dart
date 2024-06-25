import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/order/order_event.dart';
import 'package:penatu/app/bloc/order/order_state.dart';

import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  OrderBloc(this._mainRepository, this._localRepository)
      : super(InitialOrderState()) {
    on<GetOrderForm>((event, emit) async {
      await _mapGetOrderFormToState();
    });
    on<PostUserOrder>((event, emit) async {
      await _mapPostUserOrderToState(event.pesanan, event.listDetail);
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetOrderFormToState() async {
    try {
      emit(LoadingOrderState());
      double pricePerKilo = await _localRepository.getKiloPrice();
      emit(LoadedOrderState(pricePerKilo));
    } catch (e, stackTrace) {
      emit(ErrorOrderState('Terjadi Kesalahan', e.toString()));
    }
  }

  Future<void> _mapPostUserOrderToState(
    Pesanan pesanan,
    List<DetailPesanan> listDetail,
  ) async {
    try {
      emit(LoadingOrderState());

      User userSession = await _mainRepository.getUserSessionData();

      /// Making sure pesanan use default id.
      pesanan.idPesanan = null;
      pesanan.idUser = userSession.idUser;

      /// Post pesanan
      await _mainRepository.postPesanan(pesanan);

      /// Get newest pesanan
      List<Pesanan> newestPesanan =
          await _mainRepository.getPesananByStatus(userSession.idUser);


      String? idPesanan = newestPesanan.last.idPesanan;
      for (var i = 0; i < listDetail.length; i++) {
        /// Add idPesanan to detail pesanan
        listDetail[i].idPesanan = idPesanan!;
        await _mainRepository.postDetailPesanan(listDetail[i]);
      }

      emit(SubmittedOrderState());

    } catch (e, stackTrace) {
      log.e(e.toString());
      emit(ErrorOrderState('Terjadi Kesalahan', e.toString()));
    }
  }
}
