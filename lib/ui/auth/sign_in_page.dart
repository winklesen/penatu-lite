import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';
import 'package:penatu/ui/auth/magic_link_auth_page.dart';
import 'package:penatu/ui/auth/sign_up_page.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/styles/dialog.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessEmailLoginAuthState) {
            dialog(context, 'Success', 'Login Successful', false, () {
              Navigator.pushNamedAndRemoveUntil(
                context, DashboardPage.routeName,(route) => false,);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/ic_launcher.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 20),
                      if (state is LoadingAuthState)
                        CircularProgressIndicator(),
                      if (state is! LoadingAuthState)
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(SignInEmail(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                }
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignUpPage.routeName);
                              },
                              child: Text('Sign Up'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MagicLinkAuthPage.routeName);
                              },
                              child: Text('Sign In with Magic Link'),
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
}
/*
begin
  insert into public.user(id_user, nama_toko,nama_user,password,nomer_telepon, email)
        values(new.id, new.raw_user_meta_data->>'nama_toko',new.raw_user_meta_data->>'nama_user',new.encrypted_password,new.raw_user_meta_data->>'nomer_telepon',new.raw_user_meta_data->>'email' );
  return new;
end;
*/