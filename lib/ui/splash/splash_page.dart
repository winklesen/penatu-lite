import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_bloc.dart';
import 'package:penatu/app/bloc/splash/splash_event.dart';
import 'package:penatu/app/bloc/splash/splash_state.dart';
import 'package:penatu/ui/auth/sign_in_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  /// initState() called before UI build
  @override
  void initState() {
    super.initState();

    /// Call the bloc event
    context.read<SplashBloc>().add(CheckSession());
  }

  /// dispose() called before UI destroyed
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {

          /// if session exist, go to dashboard
          if (state is LoggedInSplashState) {
            Navigator.pushNamedAndRemoveUntil(
                context, DashboardPage.routeName, (_) => false);
          }
          else if (state is EmptySessionSplashState) {
            Navigator.pushNamedAndRemoveUntil(
                context, SignInPage.routeName, (_) => false);
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(128),
            child: Image.asset(
              'assets/icons/ic_launcher.png',
            ),
          ),
        ),
      ),
    );
  }
}
