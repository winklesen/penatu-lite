import 'package:equatable/equatable.dart';

/// Bloc State
/// Used for defining UI state
abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSplashState extends SplashState {}

class LoadingSplashState extends SplashState {}

class EmptySessionSplashState extends SplashState {}

class LoggedInSplashState extends SplashState {}

class ErrorSplashState extends SplashState {
  final String title, message;

  ErrorSplashState(this.title, this.message);
}
