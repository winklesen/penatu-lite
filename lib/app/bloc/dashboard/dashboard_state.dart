import 'package:equatable/equatable.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDashboardState extends DashboardState {}

class LoadingDashboardState extends DashboardState {



}
class LoadedDashboardState extends DashboardState {

  final User userSession;
  final List<Pesanan> listPesanan;

  LoadedDashboardState(this.userSession, this.listPesanan);
}

class ErrorDashboardState extends DashboardState {
  final String title, message;

  ErrorDashboardState(this.title, this.message);
}
