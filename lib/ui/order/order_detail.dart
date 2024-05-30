import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_state.dart';
import 'package:penatu/app/model/pesanan.dart';

class OrderDetailPage extends StatefulWidget {
  static const String routeName = '/order.detail';

  final Pesanan? selectedOrder;

  const OrderDetailPage({
    super.key,
    this.selectedOrder,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingOrderDetailState) {
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
                          Text('${this.widget.selectedOrder?.namaPelanggan}')
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
