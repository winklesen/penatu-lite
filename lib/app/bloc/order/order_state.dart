import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialOrderState extends OrderState {}

class LoadingOrderState extends OrderState {}

class LoadedOrderState extends OrderState {
  final double kiloPrice;

  LoadedOrderState(this.kiloPrice);
}

class SubmittedOrderState extends OrderState {}

class ErrorOrderState extends OrderState {
  final String title, message;

  ErrorOrderState(this.title, this.message);
}
