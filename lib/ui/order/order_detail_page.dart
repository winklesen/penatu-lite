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
import 'package:penatu/app/utils/constants.dart';
import 'package:penatu/ui/dashboard/widget/card_detail_order.dart';
import 'package:penatu/ui/styles/button.dart';
import 'package:penatu/ui/styles/dialog.dart';
import 'package:penatu/ui/styles/theme.dart';

class OrderDetailPage extends StatefulWidget {
  static const String routeName = '/order.detail';

  final Pesanan? selectedOrder;

  const OrderDetailPage({super.key, this.selectedOrder});

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
      statusBarIconBrightness: Brightness.light,
    ));

    orderDetail = [];
    totalPrice = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<OrderDetailBloc>()
          .add(GetOrderDetail(widget.selectedOrder!.idPesanan!));
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
              orderDetail = state.listPesananDetail;
              totalPrice = state.totalPrice;
            } else if (state is UpdatedOrderDetailState) {
              this.widget.selectedOrder?.status = state.updatedStatus;
              dialog(context, 'Berhasil', 'Pesanan telah terupdate', true, () {});
            } else if (state is ErrorOrderDetailState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingOrderDetailState || widget.selectedOrder == null) {
              return Center(child: CircularProgressIndicator());
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildImageHeader(size),
                        buildOrderDetails(context, size),
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

  Container buildImageHeader(Size size) {
    return Container(
      width: double.infinity,
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
    );
  }

  Padding buildOrderDetails(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          buildCustomerInfo(),
          const SizedBox(height: 16),
          buildOrderDetailList(size),
          buildTotalPriceRow(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Column buildCustomerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Info Pelanggan', style: _theme.textTheme.bodySmall),
        const SizedBox(height: 2),
        Text(
          '${widget.selectedOrder?.namaPelanggan}',
          style: _theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${widget.selectedOrder?.nomorTeleponPelanggan}',
          style: _theme.textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Column buildOrderDetailList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detail Pesanan', style: _theme.textTheme.bodySmall),
        SizedBox(
          height: size.height * 0.475,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: orderDetail.length,
            itemBuilder: (context, index) => CardDetailOrder(orderDetail[index]),
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withOpacity(0.25),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTotalPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${CurrencyFormat.convertToIdr(number: _calculateTotalPrice())}',
          style: _theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        PrimaryButton(
          color: getStatusColor(this.widget.selectedOrder!.status),
          label: widget.selectedOrder?.status == STATUS_DONE
              ? 'Pesanan Selesai'
              : widget.selectedOrder?.status == STATUS_PENDING
              ? 'Kerjakan Pesanan'
              : 'Selesaikan Pesanan',
          onPressed: () {
            if (widget.selectedOrder?.status != STATUS_DONE) {
              context.read<OrderDetailBloc>().add(
                PutOrderStatus(
                  widget.selectedOrder?.status == STATUS_PENDING? STATUS_ON_PROGRESS : STATUS_DONE,
                  widget.selectedOrder!.idPesanan!,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  // Method
  double _calculateTotalPrice() {
    return orderDetail.fold(0, (total, detail) => total + detail.harga);
  }



}