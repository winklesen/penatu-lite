import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostUserOrder extends OrderEvent {
  final Pesanan pesanan;
  final  List<DetailPesanan> listDetail;

  PostUserOrder(this.pesanan, this.listDetail);
}