import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAccountState extends AccountState {}

class LoadingAccountState extends AccountState {}

class LoadedAccountState extends AccountState {}

class ErrorAccountState extends AccountState {
  final String title, message;

  ErrorAccountState(this.title, this.message);
}
