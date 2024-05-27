import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_event.dart';
import 'package:penatu/app/bloc/splash/splash_state.dart';
import 'package:penatu/ui/auth/auth_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(CheckSession());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is LoggedInSplashState) {
            Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (_) => false);
          } else if (state is EmptySessionSplashState) {
            Navigator.pushNamedAndRemoveUntil(context, AuthPage.routeName,(_) => false);
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(128),
            child: Image.asset('assets/icons/ic_launcher.png',),
          ),
        ),
      ),
    );
  }
}