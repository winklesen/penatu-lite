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
  void dispose() {
    _namaTokoController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _nomorTeleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
                _buildImageLogo(),
                SizedBox(height: 18),
                Text(
                  'Sign Up',
                  style: _theme.textTheme.displayMedium,
                ),
                SizedBox(height: 18),
                _buildSignUpForm(state),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget
  Widget _buildImageLogo() {
    return Center(
      child: Image.asset(
        'assets/icons/ic_launcher.png',
        height: 120,
      ),
    );
  }

  Widget _buildSignUpForm(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildInputName(),
          SizedBox(height: 8),
          _buildInputUsername(),
          SizedBox(height: 8),
          _buildInputPhone(),
          SizedBox(height: 8),
          _buildInputEmail(),
          SizedBox(height: 8),
          _buildInputPassword(),
          SizedBox(height: 18),
          if (state is LoadingAuthState) CircularProgressIndicator(),
          if (state is! LoadingAuthState) _buildFormButton(),
        ],
      ),
    );
  }

  Widget _buildInputName() {
    return TextFormField(
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
    );
  }

  Widget _buildInputUsername() {
    return TextFormField(
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
    );
  }

  Widget _buildInputPhone() {
    return TextFormField(
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
    );
  }

  Widget _buildInputEmail() {
    return TextFormField(
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
    );
  }

  Widget _buildInputPassword() {
    return TextFormField(
      controller: _passwordController,
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
    );
  }

  Widget _buildFormButton() {
    return PrimaryButton(
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
          context.read<AuthBloc>().add(SignUpEmail(user: user));
        }
      },
    );
  }
}
