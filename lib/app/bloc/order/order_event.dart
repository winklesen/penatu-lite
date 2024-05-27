import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostUserOrder extends OrderEvent {

}
