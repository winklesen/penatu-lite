import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/styles/dialog.dart';

class MagicLinkAuthPage extends StatefulWidget {
  static const String routeName = '/magic-auth';

  const MagicLinkAuthPage({Key? key}) : super(key: key);

  @override
  _MagicLinkAuthPageState createState() => _MagicLinkAuthPageState();
}

class _MagicLinkAuthPageState extends State<MagicLinkAuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final bool isDialogShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailSentLoginAuthState) {
            dialog(context, 'Email Konfirmasi Terkirim',
                'Konfirmasi email anda ', true, () {});
            state.emailClient.onAuthStateChange.listen((data) {
              final session = data.session;
              if (session != null && mounted) {
                dialog(context, 'Success', 'Login Successful', false, () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    DashboardPage.routeName,
                    (route) => false,
                  );
                });
              }
            });
          } else if (state is FailedMagicLinkLoginAuthState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ic_launcher.png',
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text;
                      if (email.isNotEmpty) {
                        context
                            .read<AuthBloc>()
                            .add(SignInMagicLink(email: email));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Masukan email')));
                      }
                    },
                    child: Text(
                      'Send Magic Link',
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
