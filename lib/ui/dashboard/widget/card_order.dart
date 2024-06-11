import 'package:flutter/material.dart';
import 'package:penatu/app/model/pesanan.dart';
import 'package:penatu/ui/order/order_detail_page.dart';
import 'package:penatu/ui/styles/theme.dart';

class CardOrder extends StatefulWidget {
  final Pesanan pesanan;

  CardOrder(this.pesanan);

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  late ThemeData _theme;

  Color _getStatusColor() {
    if (this.widget.pesanan.status == 'done') return StatusColor.done;
    if (this.widget.pesanan.status == 'pending') return StatusColor.onProgress;
    return StatusColor.pending;
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailPage(
                  selectedOrder: this.widget.pesanan,
                )));
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 12,
                height: 100,
                decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              ),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      '${this.widget.pesanan.namaPelanggan}',
                      style: _theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Dipesan :${this.widget.pesanan.tanggalPemesanan}',
                      style: _theme.textTheme.bodySmall,
                    ),
                    Text(
                      'Diambil : ${this.widget.pesanan.tanggalPengembalian}',
                      style: _theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.arrow_right_rounded,
              //       size: _theme.iconTheme.size,
              //     ))
            ],
          )),
    );
  }
}
