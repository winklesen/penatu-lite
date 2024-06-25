import 'package:equatable/equatable.dart';

/// Bloc Event
/// Used for calling UI event
abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckSession extends SplashEvent {}
