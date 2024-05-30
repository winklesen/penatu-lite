import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/user.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAccountState extends AccountState {}

class LoadingAccountState extends AccountState {}

class LoadedAccountState extends AccountState {
  final User userSession;

  LoadedAccountState(this.userSession);
}

class SignedOutAccountState extends AccountState {}

class ErrorAccountState extends AccountState {
  final String title, message;

  ErrorAccountState(this.title, this.message);
}
