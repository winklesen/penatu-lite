import 'package:flutter/material.dart';
import 'package:penatu/app/helper/currency_helper.dart';
import 'package:penatu/app/model/detail_pesanan.dart';

class CardDetailOrder extends StatelessWidget {
  final DetailPesanan data;

  CardDetailOrder(this.data);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          child: CircleAvatar(
            child: Icon(
              data.tipeLayanan == 'satuan'
                  ? Icons.checkroom_rounded
                  : Icons.shopping_basket_rounded,
              color: Theme.of(context).colorScheme.background,
              size: 18,
            ),
          ),
        ),
      ),
      title: Text(
        data.namaDetailPesanan,
        style: _theme.textTheme.bodyMedium,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.checkroom,
            size: 12,
            color: _theme.colorScheme.secondary,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            '${data.jumlah} Item',
            style: _theme.textTheme.bodySmall,
          ),
          SizedBox(
            width: 12,
          ),
          Icon(
            Icons.scale_rounded,
            size: 12,
            color: _theme.colorScheme.secondary,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            '${data.berat ?? '-'} Kg',
            style: _theme.textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Text(
        '${CurrencyFormat.convertToIdr(number: data.harga) }',
        style: _theme.textTheme.bodySmall,
      ),
      dense: false,
    );
  }



}
