import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_event.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_state.dart';
import 'package:penatu/app/helper/currency_helper.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/app/utils/constants.dart';
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
  List<Pesanan> listPesanan = [];
  double pricePerKilo = 0;
  double totalDone = 0;
  double totalPending = 0;
  double totalOnProgress = 0;
  late ThemeData _theme;
  String filterStatus = 'All';
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetUserDashboard());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: _buildButtonPesanan(),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is LoadedDashboardState) {
              setState(() {
                userSession = state.userSession;
                listPesanan = state.listPesanan;
                pricePerKilo = state.pricePerKilo;
                totalDone = state.totalDone;
                totalPending = state.totalPending;
                totalOnProgress = state.totalOnProgress;
              });
            } else if (state is KiloUpdatedDashboardState) {
              setState(() {
                pricePerKilo = state.pricePerKilo;
              });
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
                        constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                            maxHeight: constraints.maxHeight),
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
                              const SizedBox(height: 8),
                              buildOrderList(),
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
  Widget _buildButtonPesanan() {
    return FloatingActionButton.extended(
      backgroundColor: _theme.colorScheme.primary,
      label: Text(
        'Add Pesanan',
        style: _theme.textTheme.bodyMedium
            ?.copyWith(color: _theme.colorScheme.surface),
      ),
      icon: Icon(Icons.add,
          color: _theme.colorScheme.surface, size: _theme.iconTheme.size),
      onPressed: () {
        if(pricePerKilo < 1){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Input harga per Kg')),
          );
          return;
        }
        Navigator.pushNamed(context, OrderPage.routeName);
      },
    );
  }

  Widget buildOrderList() {
    List<Pesanan> filteredList = _getFilteredOrders();
    List<Pesanan> sortedList = _sortOrders(filteredList);
    return Expanded(
        child: sortedList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 24,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Lottie.asset(
                    'assets/anims/empty_whale.json',
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'Data Pesanan Kosong',
                    style: _theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              )
            : ShaderMask(
                shaderCallback: (Rect rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _theme.primaryColor,
                      Colors.transparent,
                      Colors.transparent,
                      _theme.primaryColor,
                    ],
                    stops: [
                      0.0,
                      0.025,
                      0.905,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedList.length,
                  itemBuilder: (context, index) {
                    return CardOrder(sortedList[index]);
                  },
                ),
              ));
  }

  List<Pesanan> _getFilteredOrders() {
    if (filterStatus == 'All') {
      return listPesanan;
    }
    return listPesanan.where((order) => order.status == filterStatus).toList();
  }

  List<Pesanan> _sortOrders(List<Pesanan> orders) {
    orders.sort((a, b) {
      int compare = a.tanggalPemesanan.compareTo(b.tanggalPemesanan);
      return isAscending ? compare : -compare;
    });
    return orders;
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
              icon: Icon(Icons.history_outlined,
                  color: _theme.iconTheme.color, size: _theme.iconTheme.size),
              onPressed: () {
                Navigator.pushNamed(context, HistoryPage.routeName);
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline,
                  color: _theme.iconTheme.color, size: _theme.iconTheme.size),
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

  Widget _cardStat() {
    return DonutChart(totalDone, totalOnProgress, totalPending);
  }

  Widget _cardKiloPrice() {
    return GestureDetector(
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
          title: Text(pricePerKilo > 1
              ? 'Harga Per Kg ${CurrencyFormat.convertToIdr(number: pricePerKilo)}'
              : 'Pengingat'),
          subtitle: Text(pricePerKilo > 1
              ? 'Ketuk untuk merubah'
              : 'Tentukan harga per Kg untuk memulai transaksi'),
        ),
      ),
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
        PopupMenuButton<String>(
          icon: Icon(Icons.sort, size: _theme.iconTheme.size),
          onSelected: (value) {
            setState(() {
              if (value == 'Sort Ascending') {
                isAscending = true;
              } else if (value == 'Sort Descending') {
                isAscending = false;
              } else {
                filterStatus = value;
              }
            });
          },
          itemBuilder: (context) {
            return <String>[
              'Sort Ascending',
              'Sort Descending',
              'All',
              STATUS_PENDING,
              STATUS_ON_PROGRESS,
              STATUS_DONE
            ]
                .map((option) => PopupMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList();
          },
        ),
      ],
    );
  }
}
