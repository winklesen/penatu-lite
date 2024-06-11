import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_bloc.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_event.dart';
import 'package:penatu/app/bloc/order_detail/order_detail_state.dart';
import 'package:penatu/app/helper/currency_helper.dart';
import 'package:penatu/app/helper/log_helper.dart';
import 'package:penatu/app/model/detail_pesanan.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/ui/dashboard/widget/card_detail_order.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';

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
  late List<DetailPesanan> orderDetail;
  late double totalPrice;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    orderDetail = [];
    totalPrice = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<OrderDetailBloc>()
          .add(GetOrderDetail(this.widget.selectedOrder!.idPesanan!));
      log.i('gettt ${this.widget.selectedOrder!.idPesanan}');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
          listener: (context, state) {
            if (state is LoadedOrderDetailState) {
              this.orderDetail = state.listPesananDetail;
              this.totalPrice = state.totalPrice;
            } else if (state is UpdatedOrderDetailState) {
              dialog(
                  context, 'Berhasil', 'Pesanan telah terupdate', true, () {});
            } else if (state is ErrorOrderDetailState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingOrderDetailState ||
                this.widget.selectedOrder == null) {
              return Center(child: CircularProgressIndicator());
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  // primary: true,
                  // physics: AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints
                          .maxHeight /*- MediaQuery.of(context).viewPadding.top*/,
                      // maxHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          // height: size.height * 0.35,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/dummy_laundry.jpeg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            left: 32,
                            right: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Info Pelanggan',
                                style: _theme.textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${this.widget.selectedOrder?.namaPelanggan}',
                                style: _theme.textTheme.displaySmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${this.widget.selectedOrder?.nomorTeleponPelanggan}',
                                style: _theme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Detail Pesanan',
                                style: _theme.textTheme.bodySmall,
                              ),
                              SizedBox(
                                height: size.height * 0.475,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: orderDetail.length,
                                  itemBuilder: (context, index) {
                                    return CardDetailOrder(orderDetail[index]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.black.withOpacity(0.25),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${CurrencyFormat.convertToIdr(number: _calculateTotalPrice())}',
                                    style: _theme.textTheme.displaySmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  PrimaryButton(
                                      label: this
                                                  .widget
                                                  .selectedOrder
                                                  ?.status ==
                                              'done'
                                          ? 'Pesanan Selesai'
                                          : this.widget.selectedOrder?.status ==
                                                  'pending'
                                              ? 'Kerjakan Pesanan'
                                              : 'Selesaikan Pesanan',
                                      onPressed: () {
                                        if (this.widget.selectedOrder?.status !=
                                            'done') {
                                          context.read<OrderDetailBloc>().add(
                                              PutOrderStatus(
                                                  this
                                                              .widget
                                                              .selectedOrder
                                                              ?.status ==
                                                          'pending'
                                                      ? 'on_progress'
                                                      : 'done',
                                                  this
                                                      .widget
                                                      .selectedOrder!
                                                      .idPesanan!));
                                        }
                                      })
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        )
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

  // Method
  double _calculateTotalPrice() {
    if (orderDetail.isEmpty) return 0;

    double price = 0;
    for (var i = 0; i < orderDetail.length; i++) {
      price += orderDetail[i].harga;
    }

    return price;
  }
}
