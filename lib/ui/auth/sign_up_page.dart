import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_bloc.dart';
import 'package:penatu/app/bloc/auth/auth_event.dart';
import 'package:penatu/app/bloc/auth/auth_state.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late ThemeData _theme;
  final TextEditingController _namaTokoController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(title: Text('Sign Up')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessEmailRegisterAuthState) {
            dialog(context, 'Success', 'Register Successful', false, () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DashboardPage.routeName,
                (route) => false,
              );
            });
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
                  'Sign Up',
                  style: _theme.textTheme.displayMedium,
                ),
                SizedBox(height: 18),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namaTokoController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nama Toko',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter namaToko';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nama Pemilik',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _nomorTeleponController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your nomor telepon';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
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
                        textInputAction: TextInputAction.next,
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
                        PrimaryButton(
                          label: 'Sign Up',
                          isFullWidth: true,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final user = User(
                                idUser: '',
                                nama_toko: _namaTokoController.text,
                                nama_user: _usernameController.text,
                                password: _passwordController.text,
                                nomorTelepon: _nomorTeleponController.text,
                                email: _emailController.text,
                              );
                              context
                                  .read<AuthBloc>()
                                  .add(SignUpEmail(user: user));
                            }
                          },
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

  @override
  void dispose() {
    _namaTokoController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _nomorTeleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
