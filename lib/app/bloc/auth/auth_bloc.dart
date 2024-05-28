import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:penatu/app/utils/constants.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final MainDataSource _mainRepository;
  final LocalDataSource _localRepository;

  AuthBloc(this._mainRepository, this._localRepository)
      : super(InitialAuthState()) {

    on<SignUpEmail>((event, emit) async {
      await _mapSignUpEmailToState(event.user);
    });

    on<SignInEmail>((event, emit) async {
      await _mapSignInEmailToState(event.email, event.password);
    });

    on<SignInMagicLink>((event, emit) async {
      await _mapSignInMagicLinkToState(event.email);
    });
  }

  dispose() {
    this.close();
  }

  Future<void> _mapSignUpEmailToState(User user) async {
    try {
      emit(LoadingAuthState());
      final supabase.AuthResponse responseSignUp =
          await _mainRepository.postUserSignUp(user.email, user.password);
      if (responseSignUp.user != null) {
        await _mainRepository.putUserData(responseSignUp.user!.id,
            user.nama_toko, user.nama_user, user.nomorTelepon);
        emit(SuccessEmailLoginAuthState());
      } else {
        emit(FailedEmailLoginAuthState(errorTitle));
      }
    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }

  Future<void> _mapSignInEmailToState(String email, String password) async {
    try {
      emit(LoadingAuthState());
      final supabase.AuthResponse response =
          await _mainRepository.postUserSignIn(email, password);
      if (response.user != null) {
        emit(SuccessEmailLoginAuthState());
      } else {
        emit(FailedEmailLoginAuthState(
          errorTitle
        ));
      }
    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }

  Future<void> _mapSignInMagicLinkToState(String email) async {
    try {
      emit(LoadingAuthState());

      var response =  await _mainRepository.postUserMagicLink(email);
      emit(EmailSentLoginAuthState(response));


    } catch (e, stackTrace) {
      emit(ErrorAuthState(errorTitle, e.toString()));
    }
  }
}
