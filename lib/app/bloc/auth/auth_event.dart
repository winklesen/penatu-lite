import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/user.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEmail extends AuthEvent {
  final User user;

  SignUpEmail({required this.user});

  @override
  List<Object> get props => [user];
}

class SignInEmail extends AuthEvent {
  final String email;
  final String password;

  SignInEmail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInMagicLink extends AuthEvent {
  final String email;

  SignInMagicLink({required this.email});

  @override
  List<Object> get props => [email];
}
