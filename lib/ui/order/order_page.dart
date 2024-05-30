import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/order/order_bloc.dart';
import 'package:penatu/app/bloc/order/order_state.dart';
import 'package:penatu/ui/dashboard/dashboard_page.dart';

import '../styles/dialog.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order';

  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: SafeArea(
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is SubmittedOrderState) {
              dialog(context, 'Success', 'Data telah tersimpan', false, () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardPage.routeName,
                  (route) => false,
                );
              });
            } else if (state is ErrorOrderState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingOrderState) {
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
                          Text('List')
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
}
