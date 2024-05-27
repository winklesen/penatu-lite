import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/account/account_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/history/history_bloc.dart';
import 'package:penatu/app/bloc/order/order_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_event.dart';
import 'package:penatu/app/bloc/theme/theme_state.dart';
import 'package:penatu/app/di/injection_container.dart';
import 'package:penatu/ui/account/account_page.dart';
import 'package:penatu/ui/auth/auth_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/history/history_page.dart';
import 'package:penatu/ui/order/order_page.dart';
import 'package:penatu/ui/splash/splash_page.dart';
import 'package:penatu/ui/styles/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    /// Init BLoC provider
    /// Provide BLoC to inherited Widget
    ///
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => inject<ThemeBloc>()),
        BlocProvider(create: (_) => inject<SplashBloc>()),
        BlocProvider(create: (_) => inject<DashboardBloc>()),
        BlocProvider(create: (_) => inject<AccountBloc>()),
        BlocProvider(create: (_) => inject<HistoryBloc>()),
        BlocProvider(create: (_) => inject<OrderBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    context.select((ThemeBloc themeBloc) => themeBloc.add(GetTheme()));

    /// Root Widget
    return MaterialApp(
      title: 'Penatu',
      onGenerateTitle: (BuildContext context) => 'Penatu',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        AuthPage.routeName: (context) => AuthPage(),
        DashboardPage.routeName: (context) => DashboardPage(),
        OrderPage.routeName: (context) => OrderPage(),
        AccountPage.routeName: (context) => AccountPage(),
        HistoryPage.routeName: (context) => HistoryPage(),
      },
    );
  }
}
