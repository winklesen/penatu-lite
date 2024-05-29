import 'package:equatable/equatable.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessEmailLoginAuthState extends AuthState {}

class SuccessEmailRegisterAuthState extends AuthState {}

class FailedEmailLoginAuthState extends AuthState {
  final String message;

  FailedEmailLoginAuthState(this.message);
}

class EmailSentLoginAuthState extends AuthState {
  final GoTrueClient emailClient;

  EmailSentLoginAuthState(this.emailClient);
}

class FailedMagicLinkLoginAuthState extends AuthState {
  final String message;

  FailedMagicLinkLoginAuthState(this.message);
}

class ErrorAuthState extends AuthState {
  final String title, message;

  ErrorAuthState(this.title, this.message);
}
