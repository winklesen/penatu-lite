import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/account/account_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';

import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/history/history_bloc.dart';
import 'package:penatu/app/bloc/order/order_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_bloc.dart';
import 'package:penatu/app/bloc/theme/theme_event.dart';
import 'package:penatu/app/bloc/theme/theme_state.dart';
import 'package:penatu/app/di/injection_container.dart';
import 'package:penatu/app/utils/constants.dart';
import 'package:penatu/app/utils/constants.dart';
import 'package:penatu/ui/account/account_page.dart';
import 'package:penatu/ui/auth/magic_link_auth_page.dart';
import 'package:penatu/ui/auth/sign_in_page.dart';
import 'package:penatu/ui/auth/sign_up_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/history/history_page.dart';
import 'package:penatu/ui/order/order_detail_page.dart';
import 'package:penatu/ui/order/order_page.dart';
import 'package:penatu/ui/splash/splash_page.dart';
import 'package:penatu/ui/styles/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Init BLoC provider
    /// Provide BLoC to inherited Widget
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => inject<ThemeBloc>()), // TODO REMOVE
        BlocProvider(create: (_) => inject<SplashBloc>()),
        BlocProvider(create: (_) => inject<AuthBloc>()),
        BlocProvider(create: (_) => inject<DashboardBloc>()),
        BlocProvider(create: (_) => inject<AccountBloc>()),
        BlocProvider(create: (_) => inject<HistoryBloc>()),
        BlocProvider(create: (_) => inject<OrderBloc>()),
        BlocProvider(create: (_) => inject<OrderDetailBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    // context.select((ThemeBloc themeBloc) => themeBloc.add(GetTheme())); TODO REMOVE

    /// Root Widget
    return MaterialApp(
      title: appTitle,
      onGenerateTitle: (BuildContext context) => appTitle,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        SignInPage.routeName: (context) => SignInPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        MagicLinkAuthPage.routeName: (context) => MagicLinkAuthPage(),
        DashboardPage.routeName: (context) => DashboardPage(),
        OrderPage.routeName: (context) => OrderPage(),
        OrderDetailPage.routeName: (context) => OrderDetailPage(),
        AccountPage.routeName: (context) => AccountPage(),
        HistoryPage.routeName: (context) => HistoryPage(),
      },
    );
  }
}
