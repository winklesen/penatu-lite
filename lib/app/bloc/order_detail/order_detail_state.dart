import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';

abstract class OrderDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialOrderDetailState extends OrderDetailState {}

class LoadingOrderDetailState extends OrderDetailState {}

class LoadedOrderDetailState extends OrderDetailState {
  final List<DetailPesanan> listPesananDetail;
  final double totalPrice;

  LoadedOrderDetailState(this.listPesananDetail, this.totalPrice);
}

class UpdatedOrderDetailState extends OrderDetailState {
  final String updatedStatus;

  UpdatedOrderDetailState(this.updatedStatus);
}

class ErrorOrderDetailState extends OrderDetailState {
  final String title, message;

  ErrorOrderDetailState(this.title, this.message);
}
