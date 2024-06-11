import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_event.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_state.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/ui/account/account_page.dart';
import 'package:penatu/ui/dashboard/widget/card_order.dart';
import 'package:penatu/ui/dashboard/widget/dialog_input.dart';
import 'package:penatu/ui/dashboard/widget/donut_chart.dart';
import 'package:penatu/ui/history/history_page.dart';
import 'package:penatu/ui/order/order_page.dart';
import 'package:penatu/ui/styles/dialog.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User? userSession;
  late List<Pesanan> listPesanan;
  late double pricePerKilo, totalDone, totalPending, totalOnProgress;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    listPesanan = [];
    pricePerKilo = 0;
    totalDone = 0;
    totalPending = 0;
    totalOnProgress = 0;
    context.read<DashboardBloc>().add(GetUserDashboard());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _theme.colorScheme.primary,
        label: Text(
          'Add Pesanan',
          style: _theme.textTheme.bodyMedium
              ?.copyWith(color: _theme.colorScheme.surface),
        ),
        icon: Icon(Icons.add,
            color: _theme.colorScheme.surface, size: _theme.iconTheme.size),
        onPressed: () {
          Navigator.pushNamed(context, OrderPage.routeName);
        },
      ),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is LoadedDashboardState) {
              this.userSession = state.userSession;
              this.listPesanan = state.listPesanan;
              this.pricePerKilo = state.pricePerKilo;
              this.totalDone = state.totalDone;
              this.totalPending = state.totalPending;
              this.totalOnProgress = state.totalOnProgress;
              setState(() {});
            } else if (state is KiloUpdatedDashboardState) {
              this.pricePerKilo = state.pricePerKilo;
              dialog(context, 'Success', 'Data telah tersimpan', true, () {});
            } else if (state is ErrorDashboardState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingDashboardState) {
              return Center(child: CircularProgressIndicator());
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<DashboardBloc>().add(GetUserDashboard());
                  },
                  child: SingleChildScrollView(
                    primary: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: constraints.maxHeight),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 0, right: 16, bottom: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _textGreetings(),
                              const SizedBox(height: 8),
                              _cardStat(),
                              const SizedBox(height: 8),
                              _cardKiloPrice(),
                              _textOrder(),
                              Expanded(
                                  child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: listPesanan.length,
                                itemBuilder: (context, index) {
                                  return CardOrder(listPesanan[index]);
                                },
                              )),
                            ],
                          ),
                        )),
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
  Widget _cardStat() {
    return DonutChart(totalDone, totalOnProgress, totalPending);
  }

  Widget _cardKiloPrice() {
    return pricePerKilo > 1
        ? GestureDetector(
            onTap: () {
              dialogInputKiloPrice(context, pricePerKilo);
            },
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: _theme.iconTheme.size,
                  color: _theme.colorScheme.secondary,
                ),
                title: Text('Harga Per Kg Rp. $pricePerKilo'),
                subtitle: Text('Ketuk untuk merubah'),
                isThreeLine: false,
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              dialogInputKiloPrice(
                context,
              );
            },
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: _theme.iconTheme.size,
                  color: _theme.colorScheme.secondary,
                ),
                title: Text('Pengingat'),
                subtitle: Text('Tentukan harga per Kg untuk memulai transaksi'),
                isThreeLine: false,
              ),
            ),
          );
  }

  Widget _textGreetings() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.history_outlined,
                color: _theme.iconTheme.color,
                size: _theme.iconTheme.size,
              ),
              onPressed: () {
                Navigator.pushNamed(context, HistoryPage.routeName);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: _theme.iconTheme.color,
                size: _theme.iconTheme.size,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AccountPage.routeName);
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Halo,',
              style: _theme.textTheme.bodySmall,
            ),
            Text(
              '${userSession?.nama_user.split(' ').first}',
              style: _theme.textTheme.displaySmall,
            ),
          ],
        )
      ],
    );
  }

  Widget _textOrder() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          'My Order',
          style: _theme.textTheme.headlineSmall,
        ),
        IconButton(
          icon: Icon(Icons.sort, size: _theme.iconTheme.size),
          onPressed: () {},
        )
      ],
    );
  }
}
