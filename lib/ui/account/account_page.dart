import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/account/account_bloc.dart';
import 'package:penatu/app/bloc/account/account_event.dart';
import 'package:penatu/app/bloc/account/account_state.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/ui/splash/splash_page.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';

class AccountPage extends StatefulWidget {
  static const String routeName = '/account';

  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? userSession;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(GetUserAccount());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SafeArea(
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is LoadedAccountState) {
              this.userSession = state.userSession;
            } else if (state is SignedOutAccountState) {
              dialog(context, 'Logout', 'Anda telah keluar dari akun', false,
                  () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SplashPage.routeName,
                  (route) => false,
                );
              });
            } else if (state is ErrorAccountState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAccountState) {
              return Center(child: CircularProgressIndicator());
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        // minHeight: constraints.maxHeight,
                        maxHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildProfileHeader(),
                        _buildProfileContent()
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Widget
  Widget _buildProfileHeader(){
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 100,
            color: _theme.colorScheme.primary,
          ),
          Text(
            '${userSession?.nama_user}',
            style: _theme.textTheme.headlineMedium,
          ),
          Text(
            '${userSession?.email}',
            style: _theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(){
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: _theme.colorScheme.background,
                borderRadius: BorderRadius.circular(24)),
            padding: EdgeInsets.symmetric(
                horizontal: 32, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Personal Information',
                  style: _theme.textTheme.headlineSmall
                      ?.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.store_outlined,
                      size: 14,
                      color: _theme.iconTheme.color,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${userSession?.nama_toko}',
                      style: _theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 14,
                      color: _theme.iconTheme.color,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${userSession?.nomorTelepon}',
                      style: _theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Login and security',
                  style: _theme.textTheme.headlineSmall
                      ?.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                _buildBtnPassword(),
                Expanded(child: Container()),
                _buildBtnLogout(),
              ],
            )));
  }

  // Widget
  Widget _buildBtnPassword(){
    return SecondaryButton(
      label: 'Change Password',
      isFullWidth: true,
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
              content:
              Text('Fitur Belum Tersedia')),
        );
      },
    );
  }

Widget _buildBtnLogout(){
    return PrimaryButton(
      label: 'Logout',
      isFullWidth: true,
      color: _theme.colorScheme.error,
      onPressed: () {
        context
            .read<AccountBloc>()
            .add(LogOut());
      },
    );
}
}
