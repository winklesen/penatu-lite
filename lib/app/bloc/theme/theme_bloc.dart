import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_event.dart';
import 'package:penatu/app/bloc/theme/theme_state.dart';

import 'package:penatu/app/helper/pref_helper.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPrefHelper prefHelper;

  ThemeBloc({required this.prefHelper})
      : super(ThemeState(isDarkTheme: false)) {
    on<ThemeChanged>((event, emit) async {
      await _mapThemeChangedToState(event.isDarkTheme);
    });
    on<GetTheme>((event, emit) async {
      await _mapGetThemeToState();
    });
  }

  Future<void> _mapThemeChangedToState(bool isDarkTheme) async {
    await prefHelper.setDarkTheme(isDarkTheme);
    emit(ThemeState(isDarkTheme: isDarkTheme));
  }

  Future<void> _mapGetThemeToState() async {
    var isDarkTheme = await prefHelper.getValueDarkTheme();
    emit(ThemeState(isDarkTheme: isDarkTheme));
  }
}
