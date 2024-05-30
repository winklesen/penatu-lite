import 'package:equatable/equatable.dart';

abstract class OrderDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetOrderDetail extends OrderDetailEvent {
  final String orderId;

  GetOrderDetail(this.orderId);
}

class PutOrderStatus extends OrderDetailEvent {
  final String status, orderId;

  PutOrderStatus(this.status, this.orderId);
}
