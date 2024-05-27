import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHistoryState extends HistoryState {}

class LoadingHistoryState extends HistoryState {}
class LoadedHistoryState extends HistoryState {}

class ErrorHistoryState extends HistoryState {
  final String title, message;

  ErrorHistoryState(this.title, this.message);
}
