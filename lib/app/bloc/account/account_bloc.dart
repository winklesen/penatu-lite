import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/account/account_state.dart';

import 'package:penatu/app/bloc/account/account_event.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  AccountBloc(this._mainRepository, this._localRepository)
      : super(InitialAccountState()) {
    on<GetUserAccount>((event, emit) async {
      await _mapGetUserAccountToState();
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapGetUserAccountToState() async {
    try {
      emit(LoadingAccountState());

      emit(LoadedAccountState());
    } catch (e, stackTrace) {
      emit(ErrorAccountState('Terjadi Kesalahan', e.toString()));
    }
  }
}
