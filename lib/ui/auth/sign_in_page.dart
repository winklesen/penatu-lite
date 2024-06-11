import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';
import 'package:penatu/ui/auth/magic_link_auth_page.dart';
import 'package:penatu/ui/auth/sign_up_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late ThemeData _theme;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessEmailLoginAuthState) {
            dialog(context, 'Success', 'Login Successful', false, () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DashboardPage.routeName,
                (route) => false,
              );
            });
          } else if (state is FailedEmailLoginAuthState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ErrorAuthState) {
            dialog(context, state.title, state.message, true, () {});
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/ic_launcher.png',
                    height: 120,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Sign In',
                  style: _theme.textTheme.displayMedium,
                ),
                SizedBox(height: 18),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 18),
                      if (state is LoadingAuthState)
                        CircularProgressIndicator(),
                      if (state is! LoadingAuthState)
                        Column(
                          children: [
                            PrimaryButton(
                              label: 'Sign In',
                              isFullWidth: true,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(SignInEmail(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                }
                              },
                            ),
                            SecondaryButton(
                              label: 'Sign Up',
                              isFullWidth: true,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignUpPage.routeName);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            _divider(),
                            CustomTextButton(
                              label: 'Sign In with Magic Link',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MagicLinkAuthPage.routeName);
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget
  Widget _divider() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Text(
          '  or  ',
          style: _theme.textTheme.bodySmall,
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
