import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/pesanan.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHistoryState extends HistoryState {}

class LoadingHistoryState extends HistoryState {}

class LoadedHistoryState extends HistoryState {
  final List<Pesanan> listPesanan;

  LoadedHistoryState(this.listPesanan);
}

class ErrorHistoryState extends HistoryState {
  final String title, message;

  ErrorHistoryState(this.title, this.message);
}
