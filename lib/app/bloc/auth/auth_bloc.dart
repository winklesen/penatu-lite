import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';

import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';
import 'package:penatu/app/utils/constants.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  AuthBloc(this._mainRepository, this._localRepository)
      : super(InitialAuthState()) {

    on<SignUpEmail>((event,emit)async{
      await _mapSignUpEmailToState();
    });

    on<SignInEmail>((event,emit)async{
      await _mapSignInEmailToState();
    });

    on<SignInMagicLink>((event,emit)async{
      await _mapSignInMagicLinkToState();
    });


  }

  dispose() {
    this.close();
  }

  Future<void> _mapSignUpEmailToState() async {
    try {
      emit(LoadingAuthState());
    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }
  Future<void> _mapSignInEmailToState() async {
    try {
      emit(LoadingAuthState());
    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }
  Future<void> _mapSignInMagicLinkToState() async {
    try {
      emit(LoadingAuthState());
    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }
}
