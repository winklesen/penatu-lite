import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_bloc.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_event.dart';
import 'package:penatu/app/bloc/dashboard/dashboard_state.dart';
import 'package:animations/animations.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/app/model/user.dart';
import 'package:penatu/ui/account/account_page.dart';
import 'package:penatu/ui/history/history_page.dart';
import 'package:penatu/ui/order/order_detail.dart';
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
  late int pricePerKilo;

  @override
  void initState() {
    super.initState();
    listPesanan = [];
    pricePerKilo = 0;
    context.read<DashboardBloc>().add(GetUserDashboard());
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// big stat card
  /// Pesanan Ku
  /// siap diambil
  /// atau chip filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo ${userSession?.nama_user}'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, HistoryPage.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is LoadedDashboardState) {
              this.userSession = state.userSession;
              this.listPesanan = state.listPesanan;
              this.pricePerKilo = state.pricePerKilo;
              setState(() {

              });
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
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: listPesanan.length,
                          //     itemBuilder: (context, index) {
                          //       return _buildOrderCard(
                          //           context, listPesanan[index]);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
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

  Widget _buildOrderCard(BuildContext context, Pesanan order) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 4,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      openBuilder: (context, _) => OrderDetailPage(selectedOrder: order),
      closedBuilder: (context, openContainer) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: openContainer,
          title: Text('${order.idPesanan} - ${order.namaPelanggan}'),
          subtitle: Text(order.status),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
