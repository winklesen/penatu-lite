import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:penatu/app/bloc/account/account_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/history/history_bloc.dart';
import 'package:penatu/app/bloc/main_bloc_observer.dart';
import 'package:penatu/app/bloc/order/order_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_bloc.dart';
import 'package:penatu/app/helper/api_helper.dart';
import 'package:penatu/app/helper/pref_helper.dart';
import 'package:penatu/app/repository/local/local_data_source.dart';
import 'package:penatu/app/repository/local/local_repository.dart';
import 'package:penatu/app/repository/remote/main_data_source.dart';
import 'package:penatu/app/repository/remote/main_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final inject = GetIt.instance;

/// Injection Container
/// where boilerplate registered, & meet each other
Future<void> init() async {

  /// Bloc
  Bloc.observer = MainBlocObserver();
  inject.registerFactory(() => ThemeBloc(prefHelper: inject()));
  inject.registerFactory(() => SplashBloc(inject(), inject()));
  inject.registerFactory(() => AuthBloc(inject(), inject()));

  inject.registerFactory(() => DashboardBloc(inject(), inject()));
  inject.registerFactory(() => AccountBloc(inject(), inject()));
  inject.registerFactory(() => HistoryBloc(inject(), inject()));
  inject.registerFactory(() => OrderBloc(inject(), inject()));
  inject.registerFactory(() => OrderDetailBloc(inject(), inject()));

  /// Local
  SharedPrefHelper pref =
      SharedPrefHelper(preferences: await SharedPreferences.getInstance());
  inject.registerLazySingleton<SharedPrefHelper>(() => pref);

  /// Network
  await dotenv.load();
  final ApiHelper apiHelper = await ApiHelper.getInstance(
      dotenv.env['SUPABASE_URL'] ?? '', dotenv.env['SUPABASE_KEY'] ?? '');
  inject.registerLazySingleton<ApiHelper>(() => apiHelper);

  /// Repository
  inject.registerLazySingleton<MainDataSource>(() => MainRepository(
        inject(),
      ));
  inject.registerLazySingleton<LocalDataSource>(() => LocalRepository(
        inject(),
      ));
}
