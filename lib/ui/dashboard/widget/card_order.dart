import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    if (this.widget.pesanan.status == 'on_progress')
      return StatusColor.onProgress;
    return StatusColor.pending;
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    DateFormat formatDay = DateFormat('dd');
    DateFormat formatMonth = DateFormat('EEEE, dd MMM');

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
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [

                // Container(
                //   width: 18,
                //   height: 76,
                //   decoration: BoxDecoration(
                //       color: _getStatusColor(),
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20),
                //           bottomLeft: Radius.circular(20))),
                // ),
                // const SizedBox(
                //
                // ),

                Row(
                  children: [Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      child: Icon(
                        Random().nextDouble() > .3
                            ? Icons.checkroom_rounded
                            : Icons.shopping_basket_rounded,
                        color: Theme.of(context).colorScheme.background,
                        size: 20,
                      ),
                    ),
                  ),
                    SizedBox(width: 8,),
                    Column(
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

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.checkroom_rounded,
                              size: 12,
                              color: _theme.colorScheme.secondary,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${formatDay.format(DateFormat("yyyy-MM-dd").parse(this.widget.pesanan.tanggalPemesanan))}',
                              style: _theme.textTheme.bodySmall,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.event_available_rounded,
                              size: 12,
                              color: _theme.colorScheme.secondary,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${formatMonth.format(DateFormat("yyyy-MM-dd").parse(this.widget.pesanan.tanggalPengembalian))}',
                              style: _theme.textTheme.bodySmall,
                            ),
                          ],
                        )
                        // Text(
                        //   'Dipesan :${this.widget.pesanan.tanggalPemesanan}',
                        //   style: _theme.textTheme.bodySmall,
                        // ),
                        // Text(
                        //   'Diambil : ${this.widget.pesanan.tanggalPengembalian}',
                        //   style: _theme.textTheme.bodySmall,
                        // ),
                      ],
                    ),],
                ),


                Chip(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  labelPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(100)),
                  backgroundColor: getStatusColor(this.widget.pesanan.status)
                      .withOpacity(0.75),
                  label: Text(
                    '${this.widget.pesanan.status}',
                    style: _theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
