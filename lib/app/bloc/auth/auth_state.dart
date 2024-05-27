import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessEmailLoginAuthState extends AuthState {}

class FailedEmailLoginAuthState extends AuthState {}

class SuccessMagicLinkLoginAuthState extends AuthState {}

class FailedMagicLinkLoginAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String title, message;

  ErrorAuthState(this.title, this.message);
}
