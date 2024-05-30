import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserAccount extends AccountEvent {}

class LogOut extends AccountEvent {}
