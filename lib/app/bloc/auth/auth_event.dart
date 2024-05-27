import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEmail extends AuthEvent {}

class SignInEmail extends AuthEvent {}

class SignInMagicLink extends AuthEvent {}
